// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};


// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::Game;
use rl_chess::models::gamestate::GameState;

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
            w_turn_expiry_time: 0,
            b_turn_expiry_time: 0,

            invite_expiry,

            room_owner_address,
            invitee_address,
            white_player_address: room_owner_address,
            black_player_address: inivtee_address,
            
            // ===== Game States =====
            game_state: GameState::Awaiting,
            owner_ready: false,
            invitee_ready: false,
            
            room_start: get_block_timestamp(),
            room_end: 0,

            w_last_move_time: 0,
            b_last_move_time: 0,
            w_total_time_left: 0,
            b_total_time_left: 0,


            // Result
            result: 0, //  0:unresolved, 1:owner, 2:invitee, 3:draw
            winner: starknet::contract_address_const::<0x0>(),
        }
    }

    #[inline]
    fn set_invitee_address(invitee_address: ContractAddress) {
        self.invitee_address = invitee_address;
    }

    #[inline]
    fn set_ready(address:ContractAddress, ready:bool) {
        if (address == self.room_owner_address) {
            self.owner_ready = ready;
        } else if address == self.invitee_address {
            self.invitee_ready = ready;
        }
    }

    #[inline]
    fn switch_sides() {
        assert(self.game_state != GameState::InProgress, 'Game: game in progress');

        let temp = self.white_player_address;
        self.white_player_address = self.black_player_address;
        self.black_player_address = temp;
    }

    #[inline]
    fn set_game_state(game_state: GameState) {
        self.game_state = game_state;
    }

    #[inline]
    fn set_result(result: u8)-> u8 {
        
        if result == 1 {
            self.winner = self.room_owner_address;

        } else if result == 2 {
            self.winner = self.invitee_address;
        } else if result == 3 {
            self.winner = starknet::contract_address_const::<0x0>();
        } else {
            self.winner = starknet::contract_address_const::<0x0>();
            assert(false, 'Game: invalid result');
            return 88;
        };
        self.result = result;
        self.room_end = get_block_timestamp();
        result
    }

    #[inline]
    fn set_total_time_left(side: u8){
        // 1 == white, 2 == black
        if side == 1 {
            self.w_total_time_left = self.w_total_time_left - (get_block_timestamp() - self.b_last_move_time);
            self.w_last_move_time = get_block_timestamp();
        } else if side == 2 {
            self.b_total_time_left = self.b_total_time_left - (get_block_timestamp() - self.w_last_move_time);
            self.b_last_move_time = get_block_timestamp();
        }
    }

    #[inline]
    fn set_game_start(){
        self.w_last_move_time = get_block_timestamp();
        self.b_last_move_time = get_block_timestamp();
    }





}