use starknet::testing::{set_contract_address, set_transaction_hash};

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Internal imports

use rl_chess::store::{Store, StoreTrait};
use rl_chess::models::player::{Player, PlayerTrait};
use rl_chess::models::game::{Game, GameTrait};
use rl_chess::types::color::Color;
use rl_chess::systems::lobby::ILobbyDispatcherTrait;

// Test imports

use rl_chess::tests::setup::{setup, setup::{Systems, PLAYER, ANYONE}};

#[test]
fn test_lobby_setup() {
    // [Setup]
    let (world, _, context) = setup::create_game();
    let store = StoreTrait::new(world);

    // [Assert]
    let player = store.get_player(context.player_id);
    println!("player.address: {:?}", player.address);
    println!("context.player_id: {:?}", context.player_id); // should be address
    println!("player.name: {}", player.name);
    println!("context.player_name: {}", context.player_name);
    assert(player.address == context.player_id, 'Setup: player id');
    assert(player.name == context.player_name, 'Setup: player name');

    
    let anyone = store.get_player(context.anyone_id);
    println!("anyone.address: {:?}", anyone.address);
    println!("context.anyone_id: {:?}", context.anyone_id); // should be address
    println!("anyone.name: {}", anyone.name);
    println!("context.anyone_name: {}", context.anyone_name);
    assert(anyone.address == context.anyone_id, 'Setup: anyone id');
    assert(anyone.name == context.anyone_name, 'Setup: anyone name');

    let game = store.get_game(context.game_id); // testing store gets
    println!("game.game_id: {:?}", game.game_id);
    assert(game.game_id == context.game_id, 'Setup: game id');


    // let white = store.player(context.game_id, Color::White.into());
    // assert(white.id == context.player_id, 'Setup: white id');
    // let black = store.player(context.game_id, Color::Black.into());
    // assert(black.id == context.anyone_id, 'Setup: black id');
}