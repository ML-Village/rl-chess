use core::debug::PrintTrait;

use rl_chess::models::index::Game;
use rl_chess::types::gamestate::{GameState, IntoGameStateU8, IntoGameStateFelt252};

fn printGame(game: Game) {

    println!("Game:");
    println!("game_format_id: {}", game.game_format_id);
    println!("w_turn_expiry_time: {}", game.w_turn_expiry_time);
    println!("b_turn_expiry_time: {}", game.b_turn_expiry_time);
    println!("invite_expiry: {}", game.invite_expiry);
    print!("room_owner_address: "); game.room_owner_address.print();
    print!("invitee_address: "); game.invitee_address.print();
    print!("white_player_address: "); game.white_player_address.print();
    print!("black_player_address: "); game.black_player_address.print();
    
    // ===== Game States =====
    println!("game_state: {}", IntoGameStateU8::into(game.game_state));
    
    println!("owner_ready: {}", game.owner_ready);
    println!("invitee_ready: {}", game.invitee_ready);
    
    println!("room_start: {}", game.room_start);
    println!("room_end: {}", game.room_end);

    println!("w_last_move_time: {}", game.w_last_move_time);
    println!("b_last_move_time: {}", game.b_last_move_time);
    println!("w_total_time_left: {}", game.w_total_time_left);
    println!("b_total_time_left: {}", game.b_total_time_left);

    println!("result: {}", game.result);
    print!("winner: "); game.winner.print();
}
