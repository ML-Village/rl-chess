// Core imports

use core::debug::PrintTrait;
use core::array::ArrayTrait;
// use core::span::SpanTrait;

use starknet::ContractAddress;
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

use rl_chess::types::profile::ProfilePicType;
use rl_chess::types::gamestate::GameState;
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
    pub elo: u16,
    pub timestamp: u64,                 // date registered
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Game {
    #[key]
    pub game_id: u128,

    // configs
    pub game_format_id:u16,
    pub w_turn_expiry_time: u64,
    pub b_turn_expiry_time: u64,


    pub invite_expiry: u64, // Unix time, time for challenge to expire (0 for unlimited)

    pub room_owner_address: ContractAddress, //creator wallet address
    pub owner_elo: u16,
    pub invitee_address: ContractAddress, //invitee wallet address
    pub invitee_elo: u16,

    pub white_player_address: ContractAddress,
    pub black_player_address: ContractAddress,

    // ===== Game States =====
    pub game_state: GameState,
    pub owner_ready: bool,
    pub invitee_ready: bool,

    // timestamps in unix epoch
    pub room_start: u64,       // Unix time, started
    pub room_end: u64,         // Unix time, ended

    pub w_last_move_time: u64,
    pub b_last_move_time: u64,
    pub w_total_time_left: u64, // Unix time, total game time (0 for unlimited)
    pub b_total_time_left: u64, // Unix time, total game time (0 for unlimited)
    pub side_to_move: Color,

    // Result
    pub result: u8, //  0:unresolved, 1:owner, 2:invitee, 3:draw
    pub winner: ContractAddress, // winner wallet address
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

    pub wcp: u8,
    pub wcr: u8,
    pub wck: u8,
    pub wcb: u8,
    pub wcq: u8,

    pub bcp: u8,
    pub bcr: u8,
    pub bck: u8,
    pub bcb: u8,
    pub bcq: u8,

    pub side_to_move: Color,
    pub castling_rights: u8, // New field to store castling rights
    pub en_passant: u8, // New field to store the en passant square
    //position_history: Vec<u64>, // Zobrist hash history for threefold repetition
    pub halfmove_clock: u8, // For fifty-move rule
    pub fullmove_number: u16,
    pub last_move_time: u64,
    pub last_move_integer: u64,
}




// Keeping History Arrays seperate so that copy can be done on Board

#[derive(Drop, Serde)]
#[dojo::model]
pub struct History {

    #[key]
    pub game_id: u128,
    //pub fen: u8,
    pub fen: ByteArray, 
    pub fen_hash_hist: Array<felt252>,
    pub fen_history: ByteArray,
    // pub move_history: Array<(felt252, felt252)>,
    pub move_history_string: ByteArray, // DOJO.js not showing felt array (alpha.8, 24/09/24)
    pub move_history_integer: ByteArray,
    pub last_move_from: u8,
    pub last_move_to: u8
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
    pub available: bool
}
