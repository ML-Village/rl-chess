use starknet::testing::{set_contract_address, set_transaction_hash};

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Internal imports

use rl_chess::store::{Store, StoreTrait};
use rl_chess::models::player::{Player, PlayerTrait};
use rl_chess::models::game::{Game, GameTrait};
use rl_chess::models::board::{Board, BoardTrait};
use rl_chess::types::gamestate::{GameState, IntoGameStateU8, IntoGameStateFelt252};
use rl_chess::types::color::Color;
use rl_chess::systems::lobby::ILobbyDispatcherTrait;
use rl_chess::systems::room::IRoomDispatcherTrait;

// Test imports

use rl_chess::tests::setup::{setup, setup::{Systems, PLAYER, ANYONE}};

//
// a b c d e f g h
// +-+-+-+-+-+-+-+-+
// 7|56|57|58|59|60|61|62|63    | 7
// +-+-+-+-+-+-+-+-+
// 6|48|49|50|51|52|53|54|55    | 6
// +-+-+-+-+-+-+-+-+
// 5|40|41|42|43|44|45|46|47    | 6
// +-+-+-+-+-+-+-+-+
// 4|32|33|34|35|36|37|38|39    | 5
// +-+-+-+-+-+-+-+-+
// 3|24|25|26|27|28|29|30|31    | 4
// +-+-+-+-+-+-+-+-+
// 2|16|17|18|19|20|21|22|23    | 3
// +-+-+-+-+-+-+-+-+
// 1|8|9|10|11|12|13|14|15      | 2
// +-+-+-+-+-+-+-+-+
// 0|0|1|2|3|4|5|6|7            | 1
// +-+-+-+-+-+-+-+-+
//  a b c d e f g h

#[test]
fn test_lobby_move_castle_queenside() {
    // [Setup]
    let (world, systems, context) = setup::start_game();
    let store = StoreTrait::new(world);
    
    // [Move] White
    set_contract_address(PLAYER());
    // move b2b3
    systems.room.move(
        game_id: context.game_id,
        move_from: 9,
        move_to: 17,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] Black
    set_contract_address(ANYONE());
    // move b7b6
    systems.room.move(
        game_id: context.game_id,
        move_from: 49,
        move_to: 41,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] White
    set_contract_address(PLAYER());
    // move d2d4
    systems.room.move(
        game_id: context.game_id,
        move_from: 11,
        move_to: 27,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] Black
    set_contract_address(ANYONE());
    // move d7d5
    systems.room.move(
        game_id: context.game_id,
        move_from: 51,
        move_to: 35,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] White
    set_contract_address(PLAYER());
    // move bishop c1b2
    systems.room.move(
        game_id: context.game_id,
        move_from: 2,
        move_to: 9,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] Black
    set_contract_address(ANYONE());
    // move bishop c8b7
    systems.room.move(
        game_id: context.game_id,
        move_from: 58,
        move_to: 49,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] White
    set_contract_address(PLAYER());
    // move knight b1c3
    systems.room.move(
        game_id: context.game_id,
        move_from: 1,
        move_to: 18,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] Black
    set_contract_address(ANYONE());
    // move knight b8c6
    systems.room.move(
        game_id: context.game_id,
        move_from: 57,
        move_to: 42,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] White
    set_contract_address(PLAYER());
    // move queen d1d2
    systems.room.move(
        game_id: context.game_id,
        move_from: 3,
        move_to: 11,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] Black
    set_contract_address(ANYONE());
    // move queen d8d7
    systems.room.move(
        game_id: context.game_id,
        move_from: 59,
        move_to: 51,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    //println!("castling rights: {}", store.get_board(context.game_id).castling_rights);
    // [Move] White
    set_contract_address(PLAYER());
    // move castle queenside
    systems.room.move(
        game_id: context.game_id,
        move_from: 4,
        move_to: 2,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    //println!("castling rights: {}", store.get_board(context.game_id).castling_rights);
    
    // set_contract_address(PLAYER());
    // // move Nf3
    // systems.room.move(
    //     game_id: context.game_id,
    //     move_from: 6,
    //     move_to: 21,
    //     promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    // );

    //[Move] Black
    set_contract_address(ANYONE());
    // move castle queenside
    systems.room.move(
        game_id: context.game_id,
        move_from: 60,
        move_to: 58,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );
    
    let mut game = store.get_game(context.game_id);
    let mut board = store.get_board(context.game_id);
    board.print_board();
    println!("board started at: {}", board.last_move_time);
    println!("w_last_move_time: {}", game.w_last_move_time);
    println!("b_last_move_time: {}", game.b_last_move_time);
    println!("w_total_time_left: {}", game.w_total_time_left);
    println!("b_total_time_left: {}", game.b_total_time_left);

    println!("{}", board.to_fen());
}