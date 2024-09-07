// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};


// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::Board;
use rl_chess::types::color::Color;

mod errors {
}

#[generate_trait]
impl BoardImpl of BoardTrait {
    #[inline]
    fn new(
        game_id: u128) -> Board {

        Board {
            game_id,
            pieces: array![0,0,0,0,0,0],
            colors: array![0,0],
            side_to_move: Color::White,
            castling_rights: 0b1111,
            en_passant: 88, // 88 is the square index for "no square"
            halfmove_clock: 0,
            fullmove_number: 1,
            move_history: array![],
            move_history_string: array![],
            last_move_time: get_block_timestamp(),
        }
    }
}