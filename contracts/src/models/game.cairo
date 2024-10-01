// Core imports

use core::debug::PrintTrait;
use core::fmt::{Display, Formatter, Error};
use core::array::ArrayTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use core::traits::{Into, TryInto};
use rl_chess::utils::address::{address_to_string_literal, address_to_byte_array};


// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::{Game, Color};
use rl_chess::types::gamestate::{GameState, IntoGameStateU8, IntoGameStateFelt252};

use rl_chess::constants::DEFAULT_MAX_EXPIRY_HOURS;

mod errors {
    const GAME_INVALID_ID: felt252 = 'Game: invalid id';
    const GAME_INVALID_FORMAT_ID: felt252 = 'Game: invalid format id';
    const GAME_INVALID_EXPIRY: felt252 = 'Game: invalid expiry';
}

#[generate_trait]
impl GameImpl of GameTrait {
    
    #[inline]
    fn new(
        game_id: u128,
        game_format_id: u16,
        room_owner_address: ContractAddress,
        owner_elo: u16,
        invitee_address: ContractAddress,
        invitee_elo: u16,
        invite_expiry: u64,
        ) -> Game {
        // [Check] game_id is valid
        assert(game_id != 0, errors::GAME_INVALID_ID);
        // [Check] game_format_id is valid
        assert(game_format_id != 0, errors::GAME_INVALID_FORMAT_ID);
        // [Check] invite_expiry is valid
        assert(invite_expiry <= DEFAULT_MAX_EXPIRY_HOURS * 3600, errors::GAME_INVALID_EXPIRY);
        
        // [Return] Game
        Game {
            game_id,
            game_format_id,
            w_turn_expiry_time: 0,
            b_turn_expiry_time: 0,

            invite_expiry: invite_expiry + get_block_timestamp(),

            room_owner_address,
            owner_elo,
            invitee_address,
            invitee_elo,
            white_player_address: room_owner_address,
            black_player_address: invitee_address,
            
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
            side_to_move: Color::None,


            // Result
            result: 0, //  0:unresolved, 1:owner, 2:invitee, 3:draw
            winner: starknet::contract_address_const::<0x0>(),
        }
    }

    #[inline]
    fn set_invitee_address(ref self: Game, invitee_address: ContractAddress) {
        self.invitee_address = invitee_address;
    }

    #[inline]
    fn set_ready(ref self: Game, address:ContractAddress, ready:bool) {
        if (address == self.room_owner_address) {
            self.owner_ready = ready;
        } else if address == self.invitee_address {
            self.invitee_ready = ready;
        }
    }

    #[inline]
    fn switch_sides(ref self: Game) {
        assert(self.game_state != GameState::InProgress, 'Game: game in progress');

        let tempW = self.white_player_address.clone();
        let tempB = self.black_player_address.clone();
        self.white_player_address = tempB;
        self.black_player_address = tempW;
    }

    #[inline]
    fn set_game_state(ref self: Game, game_state: GameState) {
        self.game_state = game_state;
    }

    #[inline]
    fn set_result(ref self: Game, result: u8)-> u8 {
        
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
    fn set_total_time_left(ref self: Game, side: u8){
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
    fn set_game_start(ref self: Game){
        self.game_state = GameState::InProgress;
        self.side_to_move = Color::White;
        self.room_start = get_block_timestamp();
        self.w_last_move_time = get_block_timestamp();
        self.b_last_move_time = get_block_timestamp();
        //println!("game started at: {}", get_block_timestamp());
    }

}

// impl ArrayFelt252Display of Display<Array<felt252>> {
//     fn fmt(self: @Array<felt252>, ref f: Formatter) -> Result<(), Error> {
//         write!(f, "{:?}", self)
//     }
// }

// impl GameDisplay of Display<Game> {
//     fn fmt(self: @Game, ref f: Formatter) -> Result<(), Error> {

//         let str: ByteArray = format!("Game (
//             game_id: {}, 
//             game_format_id: {}, 
//             invite_expiry: {}
//         )", 
//             *self.game_id, 
//             *self.game_format_id,
//             *self.invite_expiry
//         );
//         f.buffer.append(@str);
//         Result::Ok(())
//     }
// }

#[cfg(test)]
mod tests {
    // Core imports
    use core::debug::PrintTrait;
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};

    // Local imports
    use super::{Game, GameTrait, 
        GameState, IntoGameStateU8, IntoGameStateFelt252,
        address_to_string_literal, address_to_byte_array
    };

    use rl_chess::utils::testers::printGame;

    // Constants

    const GAME_ID: u128 = 1;
    

    #[test]
    fn test_game_new() {
        let ROOM_OWNER_ADDRESS:ContractAddress = starknet::contract_address_const::<0xb3ff441a68610b30fd5e2abbf3a1548eb6ba6f3559f2862bf2dc757e5828ca>();
        let ZERO_ADDRESS:ContractAddress = starknet::contract_address_const::<0x0>();
        
        let game = GameTrait::new(
            game_id: GAME_ID,
            game_format_id: 1,
            room_owner_address: ROOM_OWNER_ADDRESS,
            invitee_address: ZERO_ADDRESS,
            invite_expiry: 0,
        );
        assert_eq!(game.game_id, GAME_ID);

        printGame(game);
    
    }

    #[test]
    fn test_game_set_ready() {
        let ROOM_OWNER_ADDRESS:ContractAddress = starknet::contract_address_const::<0xb3ff441a68610b30fd5e2abbf3a1548eb6ba6f3559f2862bf2dc757e5828ca>();
        let INVITEE_ADDRESS:ContractAddress = starknet::contract_address_const::<0xe29882a1fcba1e7e10cad46212257fea5c752a4f9b1b1ec683c503a2cf5c8a>();
        
        let mut game = GameTrait::new(
            game_id: GAME_ID,
            game_format_id: 1,
            room_owner_address: ROOM_OWNER_ADDRESS,
            invitee_address: INVITEE_ADDRESS,
            invite_expiry: 0,
        );

        game.set_ready(ROOM_OWNER_ADDRESS, true);
        game.set_ready(INVITEE_ADDRESS, true);

        assert_eq!(game.owner_ready, true);
        assert_eq!(game.invitee_ready, true);

        printGame(game);
    
    }
}