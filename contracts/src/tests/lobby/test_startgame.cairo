use starknet::testing::{set_contract_address, set_transaction_hash};

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Internal imports

use rl_chess::store::{Store, StoreTrait};
use rl_chess::models::player::{Player, PlayerTrait};
use rl_chess::models::game::{Game, GameTrait};
use rl_chess::types::gamestate::{GameState, IntoGameStateU8};
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
    println!("game state: {}", IntoGameStateU8::into(game.game_state));
    assert(game.game_state == GameState::InProgress, 'StartGame: Game State not in progress');

    let board = store.get_board(context.game_id);
    assert(board.side_to_move == Color::White, 'StartGame: Side to move not white');
    println!("board started at: {}", board.last_move_time);

}