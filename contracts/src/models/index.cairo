// Core imports

use core::debug::PrintTrait;
use core::array::ArrayTrait;
// use core::span::SpanTrait;

use starknet::ContractAddress;
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

use rl_chess::types::profile::ProfilePicType;
use rl_chess::types::invite::InviteState;
use rl_chess::types::color::Color;
use rl_chess::constants;



#[derive(Clone, Drop, Serde)]   // ByteArray is not copiable!
#[dojo::model]
pub struct Player {
    #[key]
    pub address: ContractAddress,   // wallet address
    //-----------------------
    pub name: felt252,
    pub profile_pic_type: ProfilePicType,
    pub profile_pic_uri: u64,     // can be anything 
    pub timestamp: u64,                 // date registered
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Game {
    #[key]
    pub game_id: u128,

    pub game_format_id:u16,

    pub room_owner_address: ContractAddress, //creator wallet address
    pub invitee_address: ContractAddress, //invitee wallet address

    pub invite_state: InviteState,
    pub invite_expiry: u64, // Unix time, time for challenge to expire (0 for unlimited)

    pub result: u8, //  0:unresolved, 1:owner, 2:invitee, 3:draw
    pub winner: ContractAddress, // winner wallet address
    
    // timestamps in unix epoch
    pub room_start: u64,       // Unix time, started
    pub room_end: u64,         // Unix time, ended


    // Game States
    pub w_turn_expiry_time: u64,
    pub b_turn_expiry_time: u64,
    pub w_total_time_left: u64, // Unix time, total game time (0 for unlimited)
    pub b_total_time_left: u64, // Unix time, total game time (0 for unlimited)
}



#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Board {
    #[key]
    pub game_id: u128,
    
    // Board States
    // pub pieces: Array<u64>, // [u64; 6],  // One bitboard for each piece type
    // pub colors: Array<u64>, // [u64; 2],  // One bitboard for each color

    pub whites: u64,
    pub blacks: u64,

    // tracking each piece type seperately and not in arrays
    pub pawns: u64,
    pub rooks: u64,
    pub knights: u64,
    pub bishops: u64,
    pub queens: u64,
    pub kings: u64,

    pub side_to_move: Color,
    pub castling_rights: u8, // New field to store castling rights
    pub en_passant: u8, // New field to store the en passant square
    //position_history: Vec<u64>, // Zobrist hash history for threefold repetition
    pub halfmove_clock: u8, // For fifty-move rule
    pub fullmove_number: u16,
    pub last_move_time: u64,
}




// Keeping History Arrays seperate so that copy can be done on Board

#[derive(Drop, Serde)]
#[dojo::model]
pub struct History {

    #[key]
    pub game_id: u128,

    pub move_history: Array<(u8, u8)>,
    pub move_history_string: Array<felt252>,
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Format {
    #[key]
    pub format_id:u16,
    pub description: felt252,
    pub turn_expiry: u64, // Unix time, time for each turn to expire (0 for unlimited)
    pub total_time_per_side: u64, // Unix time, total game time (0 for unlimited)
    pub total_time_string: felt252,
    pub increment: u8, // Unix time, time in seconds added after each turn (0 for no increment)
}
