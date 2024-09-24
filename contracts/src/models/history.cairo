// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};


// Inernal imports

use rl_chess::models::index::{Board, History};
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::types::piece::{Piece, PieceTrait, IntoU8Piece};
use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::utils::bitboard::{piece_at, color_at};
use rl_chess::utils::math::{MathTrait, MathU8};
use rl_chess::constants;

mod errors {}


#[generate_trait]
impl HistoryImpl of HistoryTrait {

    #[inline]
    fn new(game_id: u128) -> History {
        History {
            game_id: game_id,
            //fen: 1,
            fen: "",
            // move_history: ArrayTrait::<(felt252, felt252)>::new(),
            move_history_string: ArrayTrait::<felt252>::new(),
        }
    }
}


#[cfg(test)]
mod tests {
    // Core imports
    use core::debug::PrintTrait;
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};

    // Local imports
    use super::{History, HistoryTrait};

    // Constants

    const GAME_ID: u128 = 1;
    

    #[test]
    fn test_history_new() {
        // let ROOM_OWNER_ADDRESS:ContractAddress = starknet::contract_address_const::<0xb3ff441a68610b30fd5e2abbf3a1548eb6ba6f3559f2862bf2dc757e5828ca>();
        // let ZERO_ADDRESS:ContractAddress = starknet::contract_address_const::<0x0>();
        
        let history = HistoryTrait::new(
            game_id: GAME_ID,
        );
        assert_eq!(history.game_id, GAME_ID);
    }
}