// Core imports

use core::debug::PrintTrait;

// Internal imports

use rl_chess::elements::pieces::interface::PieceTrait;
use rl_chess::types::color::{Color, ColorTrait};


impl Rook of PieceTrait {
    #[inline]
    fn can(index: u8, from: u8, to: u8, whites: u64, blacks: u64) -> bool {
        // [Check] The new position is a valid one
        true
        // [Return] Move validity
        // is_available
        //     && is_free
        //     && ((is_valid_free && !is_occupied) || (is_valid_occupied && is_occupied))
    }
}