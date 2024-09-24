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

// Test imports

use rl_chess::tests::setup::{setup, setup::{Systems, PLAYER, ANYONE}};


#[test]
fn test_lobby_startgame() {
    // [Setup]
    let (world, _, context) = setup::start_game();
    let store = StoreTrait::new(world);

    // [Assert]
    // let player = store.get_player(context.player_id);
    // let anyone = store.get_player(context.anyone_id);

    let game = store.get_game(context.game_id);
    assert(game.game_id == context.game_id, 'Setup: game id');
    //println!("game state: {}", IntoGameStateFelt252::into(game.game_state));

    match game.game_state {
        GameState::Null => {
            println!("game state: Null");
        },
        GameState::Awaiting => {
            println!("game state: Awaiting");
        },
        GameState::Withdrawn => {
            println!("game state: Withdrawn");
        },
        GameState::InProgress => {
            println!("game state: InProgress");
        },
        GameState::Resolved => {
            println!("game state: Resolved");
        },
        GameState::Draw => {
            println!("game state: Draw");
        },
        GameState::Expired => {
            println!("game state: Expired");
        },
        GameState::Accepted => {
            println!("game state: Accepted");
        },

        _ => {
            println!("game state: {}", IntoGameStateU8::into(game.game_state));
        }
    }

    assert(game.game_state == GameState::InProgress, 'StartGame:Game not InProgress');

    let mut board = store.get_board(context.game_id);
    let mut history = store.get_history(context.game_id);

    assert(board.side_to_move == Color::White, 'StartGame:Side2mov not W');
    
    board.print_board();
    println!("board started at: {}", board.last_move_time);
    println!("room started at: {}", game.room_start);
    // match board.side_to_move {
    //     Color::White => {
    //         println!("side_to_move: W");
    //     },
    //     Color::Black => {
    //         println!("side_to_move: B");
    //     },
    //     _ => {
    //         println!("side_to_move: null");
    //     }
    // } // Side to Move printed in print_board()
    println!("w_last_move_time: {}", game.w_last_move_time);
    println!("b_last_move_time: {}", game.b_last_move_time);
    println!("w_total_time_left: {}", game.w_total_time_left);
    println!("b_total_time_left: {}", game.b_total_time_left);


    // print fen
    println!("FEN: {}", board.to_fen());

    println!("history fen: {}", history.fen);
}