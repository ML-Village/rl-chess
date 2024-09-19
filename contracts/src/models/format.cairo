// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};


// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::Format;

mod errors {
}

#[generate_trait]
impl FormatImpl of FormatTrait {
    #[inline]
    fn new(
        format_id: u16,
        description: felt252,
        turn_expiry: u64,
        total_time_per_side: u64,
        total_time_string: felt252,
        increment: u8,
        available: bool
        ) -> Format {

        Format {
            format_id,
            description,
            turn_expiry,
            total_time_per_side,
            total_time_string,
            increment,
            available
        }
    }
}