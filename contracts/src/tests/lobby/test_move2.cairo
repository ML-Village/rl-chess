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


#[test]
fn test_lobby_move2() {
    // [Setup]
    let (world, systems, context) = setup::start_game();
    let store = StoreTrait::new(world);

    // [Assert]
    // let player = store.get_player(context.player_id);
    // let anyone = store.get_player(context.anyone_id);

    // match game.game_state {
    //     GameState::Null => {
    //         println!("game state: Null");
    //     },
    //     GameState::Awaiting => {
    //         println!("game state: Awaiting");
    //     },
    //     GameState::Withdrawn => {
    //         println!("game state: Withdrawn");
    //     },
    //     GameState::InProgress => {
    //         println!("game state: InProgress");
    //     },
    //     GameState::Resolved => {
    //         println!("game state: Resolved");
    //     },
    //     GameState::Draw => {
    //         println!("game state: Draw");
    //     },
    //     GameState::Expired => {
    //         println!("game state: Expired");
    //     },
    //     GameState::Accepted => {
    //         println!("game state: Accepted");
    //     },

    //     _ => {
    //         println!("game state: {}", IntoGameStateU8::into(game.game_state));
    //     }
    // }

    //assert(game.game_state == GameState::InProgress, 'StartGame:Game not InProgress');
    
    // [Move] White
    set_contract_address(PLAYER());
    // move e2e4
    systems.room.move(
        game_id: context.game_id,
        move_from: 11,
        move_to: 27,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] Black
    set_contract_address(ANYONE());
    // move c7c6
    systems.room.move(
        game_id: context.game_id,
        move_from: 50,
        move_to: 42,
        promotion: 5 // default is 5 (queen) - 2 (rook), 3 (knight)
    );

    // [Move] White
    set_contract_address(PLAYER());
    // move c7c6
    systems.room.move(
        game_id: context.game_id,
        move_from: 1,
        move_to: 18,
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