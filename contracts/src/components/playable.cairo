#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;
    use traits::{Into, TryInto};

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
    use rl_chess::models::index::{Player, Game, Format, Board};
    use rl_chess::models::player::{PlayerTrait, PlayerAssert};
    use rl_chess::models::game::{GameTrait};
    use rl_chess::models::board::{BoardTrait};
    use rl_chess::types::profile::ProfilePicType;
    use rl_chess::types::gamestate::GameState;
    use rl_chess::types::color::Color;
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

        const NOT_PLAYERS_TURN:felt252 = 'Not player move turn';
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
            increment: u8
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);


            store.set_format(Format {
                format_id: (world.uuid() + 1).try_into().unwrap(),
                description,
                turn_expiry,
                total_time_per_side,
                total_time_string,
                increment
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
            assert(game.invitee_address == starknet::contract_address_const::<0x0>(), 
                errors::ALREADY_OCCUPIED);

            game.invitee_address = invitee_address;
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
            assert(game.game_state == GameState::Accepted, errors::GAME_NOT_ACCEPTED);

            if(caller_address == game.room_owner_address){
                game.owner_ready = true;
            } else {
                game.invitee_ready = true;
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
            assert(game.invitee_address != starknet::contract_address_const::<0x0>(),
                errors::NOT_ENOUGH_PLAYERS);

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
            assert(
                (game.room_owner_address == caller_address
                || game.invitee_address == caller_address), errors::NOT_PLAYER_OF_GAME);

            assert(game.game_state == GameState::Accepted, errors::GAME_NOT_ACCEPTED);

            assert(game.owner_ready && game.invitee_ready, errors::NOT_ALL_READY);
            
            game.set_game_start();
            store.set_game(game);
            
            //TODO: add game format config setup to board
            board.start_board();
            store.set_board(board);
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
            //assert caller in game
            assert((caller_address == game.white_player_address) || 
                (caller_address == game.black_player_address), errors::NOT_PLAYER_OF_GAME);
            //assert game in progress
            assert(game.game_state == GameState::InProgress, errors::GAME_NOT_IN_PROGRESS);

            let callerIsWhite = (game.white_player_address == caller_address);

            let mut board = store.get_board(game_id);

            if callerIsWhite {
                assert(board.side_to_move == Color::White, errors::NOT_PLAYERS_TURN);
            } else {
                assert(board.side_to_move == Color::Black, errors::NOT_PLAYERS_TURN);
            }

            board.move_piece(move_from, move_to, promotion);
            store.set_board(board);

            // move history
            // position history
            // last move time
            // check if game is over -- checkmate, stalemate, draw, or time

        }
    }

}
