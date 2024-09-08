// Core imports

use core::debug::PrintTrait;
use traits::{Into, TryInto};

// Internal imports

use rl_chess::elements::pieces::interface::PieceTrait;
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::helpers::from_to::FROM_TO_VEC;
use rl_chess::models::board::Board;
use rl_chess::utils::bitboard::{piece_at, color_at};
use rl_chess::helpers::bitmap::Bitmap;

mod errors {
    const BOARD_NO_PIECE_TO_MOVE: felt252 = 'Board: no piece to move';
}



impl Pawn of PieceTrait {
    #[inline]
    fn can(bitboard: u64, from: u8, to: u8, whites: u64, blacks: u64) -> bool {

        // [Check] The new position is a valid one
        true
        // [Return] Move validity
        // is_available
        //     && is_free
        //     && ((is_valid_free && !is_occupied) || (is_valid_occupied && is_occupied))
    }

    #[inline]
    fn friendly_occupied(from:u8, board: Board) -> u64 {
        let color_from  = color_at(board, from);
        assert(color_from != Option::None, errors::BOARD_NO_PIECE_TO_MOVE);
        let color_from = color_from.unwrap();

        if color_from == Color::White {
            board.whites
        }else{
            board.blacks
        }

    }
}

#[generate_trait]
impl PawnImpl of PawnTrait {
    #[inline]
    fn generate_possible_pawn_moves(from:u8, board: Board) -> Array<FROM_TO_VEC> {
        let mut moves: Array<FROM_TO_VEC> = array![];

        let piece_from = piece_at(board, from);
        let mut color_from  = color_at(board, from);
        assert(
            piece_from != Option::None && color_from != Option::None, 
            errors::BOARD_NO_PIECE_TO_MOVE);
        
        //let piece_from = piece_from.unwrap();
        let color_from = color_from.unwrap();
        
        //let from_bitboard:u64 = Bitmap::set_bit_at(0, from, true);
        
        //Single Push
        let single_push_to_index = if color_from == Color::White { from + 8 } else { from - 8 };

        let to_bitboard:u64 = Bitmap::set_bit_at(0, single_push_to_index, true);
        
        if to_bitboard & PieceTrait::friendly_occupied(from, board) == 0 {
            moves.append(
                FROM_TO_VEC{
                    from, 
                    to: single_push_to_index
                }
            );
        }

        moves
    }
}