// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};


// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::Game;
use rl_chess::models::invite_state::InviteState;

mod errors {
    const GAME_INVALID_ID: felt252 = 'Game: invalid id';
    const GAME_INVALID_FORMAT_ID: felt252 = 'Game: invalid format id';
}

#[generate_trait]
impl GameImpl of GameTrait {
    #[inline]
    fn new(
        game_id: u128,
        game_format_id: u16,
        room_owner_address: ContractAddress,
        invitee_address: ContractAddress,
        invite_expiry: u64,
        ) -> Game {
        // [Check] game_id is valid
        assert(game_id != 0, errors::GAME_INVALID_ID);
        // [Check] game_format_id is valid
        assert(game_format_id != 0, errors::GAME_INVALID_FORMAT_ID);
        // [Return] Game
        Game {
            game_id,
            game_format_id,
            room_owner_address,
            invitee_address,
            invite_expiry,
            invite_state: InviteState::Awaiting,
            result: 0,
            winner: starknet::contract_address_const::<0x0>(),
            room_start: get_block_timestamp(),
            room_end: 0,

            w_turn_expiry_time: 0,
            b_turn_expiry_time: 0,
            w_total_time_left: 0,
            b_total_time_left: 0,
        }
    }
}