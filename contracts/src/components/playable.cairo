use rl_chess::helpers::math::Math;

#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;
    use traits::{Into, TryInto};
    use core::num::traits::Bounded;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::info::{get_caller_address, get_block_timestamp};
    use starknet::storage::Map as StorageMap;

    // Dojo imports

    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;

    // Internal imports

    use rl_chess::constants;
    use rl_chess::store::{Store, StoreTrait};
    use rl_chess::models::index::{Player, Game, Format, Board, History};
    use rl_chess::models::player::{PlayerTrait, PlayerAssert};
    use rl_chess::models::game::{GameTrait};
    use rl_chess::models::board::{BoardTrait};
    use rl_chess::models::history::{HistoryTrait};
    use rl_chess::types::profile::ProfilePicType;
    use rl_chess::types::gamestate::GameState;
    use rl_chess::types::color::{Color, ColorTrait};
    use rl_chess::types::piece::Piece;
    use rl_chess::helpers::math::{MathTrait as MathSubAbsTrait};
    use rl_chess::utils::seeder::{make_seed};

    // Errors

    mod errors {
        const NOT_OWNER:felt252 = 'Not owner of game';
        const NOT_INVITEE:felt252 = 'Not invitee to game';
        const NOT_PLAYER_OF_GAME:felt252 = 'Not player of game';
        const OWNER_CANNOT_INVITE_SELF:felt252 = 'Owner cannot invite self';
        const ALREADY_OCCUPIED:felt252 = 'Game occupied';
        const GAME_IN_PROGRESS:felt252 = 'Game in progress';
        const GAME_NOT_IN_PROGRESS:felt252 = 'Game not in progress';
        const GAME_NOT_ACCEPTED:felt252 = 'Game not accepted';
        const NOT_ALL_READY:felt252 = 'Not all players ready';
        const NOT_ENOUGH_PLAYERS:felt252 = 'Not enough players';
        const OWNER_NOT_IN_GAME:felt252 = 'Owner not in game';
        const TIME_OVER:felt252 = 'Player ran out of time';
        const NOT_PLAYERS_TURN:felt252 = 'Not player move turn';
        const INVALID_CASTLING: felt252 = 'Invalid castling';
    }

    // Storage

    #[storage]
    struct Storage {
        format_id: u16,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        
        // ===== Player Funcs =====
        fn registerPlayer(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            address: ContractAddress,
            name: felt252,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64,
        )-> Player{
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            let player = PlayerTrait::new(address,name,profile_pic_type,profile_pic_uri);
            
            store.set_player(player);
            
            store.get_player(address)
        }

        fn updatePlayer(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            address: ContractAddress,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64,
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            let mut player = store.get_player(address);
            player.profile_pic_type = profile_pic_type;
            player.profile_pic_uri = profile_pic_uri;
            store.set_player(player);
        }

        // ===== Game Format Funcs =====

        fn addGameFormat(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            description: felt252, 
            turn_expiry: u64, 
            total_time_per_side: u64, 
            total_time_string: felt252, 
            increment: u8,
            available: bool
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);


            store.set_format(Format {
                format_id: (world.uuid() + 1).try_into().unwrap(),
                description,
                turn_expiry,
                total_time_per_side,
                total_time_string,
                increment,
                available
            });

        }

        fn removeGameFormat(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            format_id: u16,
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let gameFormat = store.get_format(format_id);
            store.delete_format(gameFormat);
        }

        // ===== Game Model Funcs (Lobby) =====
        fn createInviteGame(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_format_id: u16,
            room_owner_address: ContractAddress,
            invitee_address: ContractAddress,
            invite_expiry: u64,
        )->u128{
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let game_id = make_seed(room_owner_address, world.uuid());
            assert(room_owner_address != invitee_address, errors::OWNER_CANNOT_INVITE_SELF);

            let mut game = GameTrait::new(
                    game_id,
                    game_format_id,
                    room_owner_address,
                    invitee_address,
                    invite_expiry,
                );

            let game_format = store.get_format(game_format_id);
            let mut board = BoardTrait::new(game_id);
            let mut history = HistoryTrait::new(game_id);

            game.w_turn_expiry_time = game_format.turn_expiry;
            game.b_turn_expiry_time = game_format.turn_expiry;
            game.w_total_time_left = game_format.total_time_per_side;
            game.b_total_time_left = game_format.total_time_per_side;

            // Format {
            //     format_id,
            //     description,
            //     turn_expiry,
            //     total_time_per_side,
            //     total_time_string,
            //     increment,  // left with increment to use in Move!
            // }

            store.set_game(game);
            store.set_board(board);
            store.set_history(history);
            game.game_id

        }

        fn updateInvitee(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            room_owner_address: ContractAddress,
            invitee_address: ContractAddress,
            invite_expiry: u64,
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            assert(game.room_owner_address == room_owner_address, errors::NOT_OWNER);

            game.invitee_address = invitee_address;
            game.invite_expiry = invite_expiry; // TODO: update with real calculation of time + expiry
            store.set_game(game);
        }

        fn replyInvite(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            invitee_address: ContractAddress,
            game_id: u128,
            accepted: bool,
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            let mut game = store.get_game(game_id);
            // println!("reply Invite");
            // println!("caller_address: {:?}", invitee_address);
            // println!("room_owner_address: {:?}", game.room_owner_address);
            // println!("invitee_address: {:?}", game.invitee_address);
            assert(game.invitee_address != game.room_owner_address, errors::OWNER_CANNOT_INVITE_SELF);
            assert(game.invitee_address == invitee_address, errors::NOT_INVITEE);

            if accepted {
                game.game_state = GameState::Accepted;
            } else {
                game.invitee_address = starknet::contract_address_const::<0x0>();
            }
            store.set_game(game);
        }

        fn joinGame(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            invitee_address: ContractAddress,
        ){
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            assert(game.room_owner_address != invitee_address, errors::OWNER_CANNOT_INVITE_SELF);
            assert(game.invitee_address == starknet::contract_address_const::<0x0>(), 
                errors::ALREADY_OCCUPIED);

            game.invitee_address = invitee_address;
            if(game.room_owner_address==game.white_player_address) {
                game.black_player_address = invitee_address;
            } else if (game.room_owner_address==game.black_player_address) {
                game.white_player_address = invitee_address;
            } else {
                assert(false, errors::OWNER_NOT_IN_GAME);
            }
            game.game_state = GameState::Accepted;
            store.set_game(game);
        }

        fn leaveGame(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            invitee_address: ContractAddress,
        ){
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            assert(game.game_state != GameState::InProgress, errors::GAME_IN_PROGRESS);
            assert(game.invitee_address == invitee_address, errors::NOT_INVITEE);

            game.invitee_address = starknet::contract_address_const::<0x0>();
            game.game_state = GameState::Awaiting;
            store.set_game(game);
        }

        fn ownerWithdrawGame(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            room_owner_address: ContractAddress,
        ){
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            assert(game.room_owner_address == room_owner_address, errors::NOT_OWNER);

            game.game_state = GameState::Withdrawn;
            store.set_game(game);
        }

        fn readyUp(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            caller_address: ContractAddress,
        ){
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            assert(
                (game.room_owner_address == caller_address
                || game.invitee_address == caller_address), errors::NOT_PLAYER_OF_GAME);
            
            //assert(game.game_state == GameState::Accepted, errors::GAME_NOT_ACCEPTED);

            if(caller_address == game.room_owner_address){
                game.owner_ready = true;
            } else if (caller_address == game.invitee_address) {
                game.invitee_ready = true;
            } else {
                assert(false, errors::NOT_PLAYER_OF_GAME);
            }
            store.set_game(game);
        }


        // ===== Game Funcs (Game Starters) =====
        fn switchSides(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            caller_address: ContractAddress,
        ){
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            assert(game.room_owner_address == caller_address, errors::NOT_OWNER);
            // assert(game.invitee_address != starknet::contract_address_const::<0x0>(),
            //     errors::NOT_ENOUGH_PLAYERS);

            game.switch_sides(); // internal asserts game not in progress
            store.set_game(game);
        }

        fn startGame(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            caller_address: ContractAddress,
        ){
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            let mut board = store.get_board(game_id);
            let mut history = store.get_history(game_id);
            assert(
                (game.room_owner_address == caller_address
                || game.invitee_address == caller_address), errors::NOT_PLAYER_OF_GAME);

            assert(game.game_state == GameState::Accepted, errors::GAME_NOT_ACCEPTED);

            assert(game.owner_ready && game.invitee_ready, errors::NOT_ALL_READY);
            
            game.set_game_start();
            store.set_game(game);
            
            //TODO: add game format config setup to board
            board.start_board();
            history.fen = board.to_fen();
            store.set_board(board);
            store.set_history(history);
        }

        // ===== Board Funcs =====

        fn movePiece(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
            caller_address: ContractAddress,
            move_from: u8,
            move_to: u8,
            promotion: u8,
        ){  
            let store: Store = StoreTrait::new(world);
            let mut game = store.get_game(game_id);
            let mut board = store.get_board(game_id);
            let mut white_player = store.get_player(game.white_player_address);
            let mut black_player = store.get_player(game.black_player_address);

            //assert caller in game
            assert((caller_address == game.white_player_address) || 
                (caller_address == game.black_player_address), errors::NOT_PLAYER_OF_GAME);
            //assert game in progress
            assert(game.game_state == GameState::InProgress, errors::GAME_NOT_IN_PROGRESS);

            let callerIsWhite = (game.white_player_address == caller_address);

            // check if it's the caller's turn
            if callerIsWhite {
                assert(board.side_to_move == Color::White && game.side_to_move == Color::White, 
                    errors::NOT_PLAYERS_TURN);
                // also update game model
            } else {
                assert(board.side_to_move == Color::Black && game.side_to_move == Color::Black, 
                    errors::NOT_PLAYERS_TURN);
            }

            // check if game is over by time:
            let current_time: u64 = get_block_timestamp();
            let player_time_left:i64 = if(callerIsWhite){
                game.w_total_time_left.try_into().unwrap() - (current_time - game.b_last_move_time).try_into().unwrap()
            }else{
                game.b_total_time_left.try_into().unwrap() - (current_time - game.w_last_move_time).try_into().unwrap()
            };

            // update if player ran out of time, and set game to over
            if player_time_left <= 0 {
                if(callerIsWhite){
                    game.w_total_time_left = 0;
                    game.result = if(game.white_player_address == game.room_owner_address){2} else {1};
                    game.winner = game.black_player_address;
                } else {
                    game.b_total_time_left = 0;
                    game.result = if(game.black_player_address == game.room_owner_address){2} else {1};
                    game.winner = game.white_player_address;
                }
                
                game.game_state = GameState::Resolved;
                game.room_end = get_block_timestamp();
            } else {

                // if player not out of time, move, update board and history
                let mut history = store.get_history(game_id);
                
                // store move history params
                let move_integer = format!("{}", board.last_move_integer);
                let piece_from = board.piece_at(move_from).unwrap();
                let color_from = board.color_at(move_from).unwrap();
                let enpassant_capture_square = board.is_enpassant_capture(move_from, move_to);
                
                let capture_string:ByteArray = if (enpassant_capture_square < 64){
                    "x"
                } else if (board.is_normal_capture(move_from, move_to)) {
                    "x"
                } else {
                    ""
                };

                let pawnletter: ByteArray = if(enpassant_capture_square<64 || board.is_normal_capture(move_from, move_to)){
                    let mut temp_string:ByteArray = "";
                    let file:ByteArray = match (move_from % 8) {
                        0 => "a",
                        1 => "b",
                        2 => "c",
                        3 => "d",
                        4 => "e",
                        5 => "f",
                        6 => "g",
                        7 => "h",
                        _ => "",
                    };
                    temp_string += file;
                    temp_string += format!("{}", ((move_from / 8) + 1));
                    temp_string
                }else{""};

                let piece_from_string:ByteArray = match (piece_from, color_from) {
                    (Piece::Pawn, Color::White) => pawnletter,
                    (Piece::Rook, Color::White) => "R",
                    (Piece::Knight, Color::White) => "N",
                    (Piece::Bishop, Color::White) => "B",
                    (Piece::Queen, Color::White) => "Q",
                    (Piece::King, Color::White) => "K",
                    (Piece::Pawn, Color::Black) => pawnletter,
                    (Piece::Rook, Color::Black) => "r",
                    (Piece::Knight, Color::Black) => "n",
                    (Piece::Bishop, Color::Black) => "b",
                    (Piece::Queen, Color::Black) => "q",
                    (Piece::King, Color::Black) => "k",
                    _ => "",
                };

                let destination_file:ByteArray = if (enpassant_capture_square < 64) {
                    match (enpassant_capture_square % 8) {
                        0 => "a",
                        1 => "b",
                        2 => "c",
                        3 => "d",
                        4 => "e",
                        5 => "f",
                        6 => "g",
                        7 => "h",
                        _ => "",
                    }
                } else {
                    match (move_to % 8) {
                        0 => "a",
                        1 => "b",
                        2 => "c",
                        3 => "d",
                        4 => "e",
                        5 => "f",
                        6 => "g",
                        7 => "h",
                        _ => "",
                    }
                };

                let destination_rank:ByteArray = format!("{}", ((move_to / 8) + 1));

                board.move_piece(move_from, move_to, promotion);
                game.side_to_move = board.side_to_move;

                // check if the move puts the other player in check
                let check_string:ByteArray = if(board.is_in_check(board.side_to_move)){
                    "+"
                } else {
                    ""
                };

                //history.fen = board.to_fen();
                let (board_fen, board_fen_hash) = board.to_fen_and_boardfen_hash();
                history.fen = board_fen.clone();
                history.fen_history += format!(" {}{}. ", move_integer, color_from.to_string_char());
                history.fen_history += board_fen.clone();
                history.fen_hash_hist.append(board_fen_hash);

                // update move_history_integers
                if(board.side_to_move == Color::Black) {
                    history.move_history_integer += format!("{}. {}-{}", move_integer, move_from, move_to);
                } else {
                    history.move_history_integer += format!(" {}-{} ", move_from, move_to);
                }

                // update move_history_strings
                if(board.side_to_move == Color::Black) {
                    // check for castling
                    if (piece_from_string == "K" && MathSubAbsTrait::sub_abs(move_from, move_to) == 2) {
                        
                        if (move_to == 6){
                            //kingside castle
                            history.move_history_string += format!("{}. 0-0", move_integer);
                        } else if (move_to == 2) {
                            //queenside castle
                            history.move_history_string += format!("{}. 0-0-0", move_integer);
                        } else {
                            assert(false, errors::INVALID_CASTLING);
                        }


                    } else {
                        history.move_history_string += format!("{}. ", move_integer);
                        history.move_history_string += piece_from_string;
                        history.move_history_string += capture_string;
                        history.move_history_string += destination_file;
                        history.move_history_string += destination_rank;
                        history.move_history_string += check_string;
                    }

                } else {

                    if (piece_from_string == "k" && MathSubAbsTrait::sub_abs(move_from, move_to) == 2) {
                        
                        if (move_to == 62){
                            //kingside castle
                            history.move_history_string += format!(" 0-0");
                        } else if (move_to == 58) {
                            //queenside castle
                            history.move_history_string += format!(" 0-0-0");
                        } else {
                            assert(false, errors::INVALID_CASTLING);
                        }

                    } else {
                        history.move_history_string += " ";
                        history.move_history_string += piece_from_string;
                        history.move_history_string += capture_string;
                        history.move_history_string += destination_file;
                        history.move_history_string += destination_rank;
                        history.move_history_string += check_string;
                        history.move_history_string += " / ";
                    }
                }

                // update last move from and to in History model
                history.last_move_from = move_from;
                history.last_move_to = move_to;
                
                // last move time in Game Model (Board model updated in board.move_piece())
                if(callerIsWhite){
                    game.set_total_time_left(1);
                } else {
                    game.set_total_time_left(2);
                }

                // check if game is over -- stalemate, draw
                if (board.is_draw() || history.is_draw_by_repetition()) {
                    game.game_state = GameState::Resolved;
                    game.result = 3;
                    game.winner = starknet::contract_address_const::<0x0>();
                    game.room_end = get_block_timestamp();
                }

                // check if game is over -- checkmate
                if (board.is_checkmate()) {
                    game.game_state = GameState::Resolved;
                    game.result = if(callerIsWhite){1} else {2};

                    // because at this point, side_to_move is already updated to the other player,
                    // other player is being check-mated
                    game.winner = if(board.side_to_move == Color::White){game.black_player_address} else {game.white_player_address};
                    game.room_end = get_block_timestamp();
                }

                // update store
                store.set_history(history);
            }

            // update store
            store.set_board(board);
            store.set_game(game);
        }

        fn getFen(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            game_id: u128,
        ) -> ByteArray {
            let store: Store = StoreTrait::new(world);
            let mut board = store.get_board(game_id);
            board.to_fen()
        }
    }

}

fn calculate_elo(white_elo: u16, black_elo: u16, result: u16, k:u16) -> (u16, u16) {
    let mut white_new_elo: i16 = white_elo.try_into().unwrap();
    let mut black_new_elo: i16 = black_elo.try_into().unwrap();

    // let eWhitePower: i16 = ((black_new_elo - white_new_elo) / 400).try_into().unwrap();
    // let eBlackPower: i16 = ((white_new_elo - black_new_elo) / 400).try_into().unwrap();

    // let eWhite:i16 = 1 / (1 + Math::pow(10_i16, eWhitePower));
    // let eBlack:i16 = 1 / (1 + Math::pow(10_i16, eBlackPower));

    // let saWhite:i16 = if (result == 1) {10} else if (result == 0) {0} else {5};
    // let saBlack:i16 = if (result == 1) {0} else if (result == 0) {10} else {5};

    // white_new_elo = white_elo.try_into().unwrap() + (k.try_into().unwrap() * (saWhite - (eWhite*10)/10));
    // black_new_elo = black_elo.try_into().unwrap() + (k.try_into().unwrap() * (saBlack - (eBlack*10)/10));
    
    (white_new_elo.try_into().unwrap(), black_new_elo.try_into().unwrap())
}