// Core imports

use core::debug::PrintTrait;

// Internal imports
use rl_chess::types::piece::{Piece};
use rl_chess::elements::pieces::interface::PieceTrait;
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::helpers::from_to::FROM_TO_VEC;
use rl_chess::models::board::Board;
use rl_chess::utils::bitboard::{piece_at, color_at, 
    Magic, generate_rook_masks, generate_sliding_moves};
use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::constants::{FILE_A, FILE_H, RANK_1, RANK_8};


mod errors {
    const BOARD_NO_PIECE_TO_MOVE: felt252 = 'Board: no piece to move';
}


impl Knight of PieceTrait {
    #[inline]
    fn can(board: Board, from: u8, to: u8) -> bool {
        // [Check] The new position is a valid one
        let possible_moves = KnightImpl::generate_possible_knight_moves(from, board);

        let mut i = 0;
        loop {
            if i == possible_moves.len() {
                break false;
            }
            let move = *possible_moves[i];
            if move.from == from && move.to == to {
                break true;
            }
            i += 1;
        }

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
impl KnightImpl of KnightTrait {
    #[inline]
    fn generate_possible_knight_moves(from:u8, board: Board) -> Array<FROM_TO_VEC> {
        let mut moves: Array<FROM_TO_VEC> = array![];
        //let from_bitboard: u64 = Bitmap::set_bit_at(0, from, true);
        let friendly_pieces = Knight::friendly_occupied(from, board);

        // Knight move offsets
        let offsets: Array<(i8, i8)> = array![
            (-2, -1), (-2, 1), (-1, -2), (-1, 2),
            (1, -2), (1, 2), (2, -1), (2, 1)
        ];

        let mut i = 0;
        loop {
            if i == offsets.len() {
                break;
            }
            let (row_offset, col_offset) = *offsets[i];
            let from_row = from / 8;
            let from_col = from % 8;

            let to_row = (from_row.try_into().unwrap() + row_offset).try_into().unwrap_or(88_u8);
            let to_col = (from_col.try_into().unwrap() + col_offset).try_into().unwrap_or(88_u8);

            if to_row < 8 && to_col < 8 {
                let to = to_row * 8 + to_col;
                let to_bitboard = Bitmap::set_bit_at(0, to, true);

                if to_bitboard & friendly_pieces == 0 {
                    moves.append(FROM_TO_VEC { from, to });
                }
            }

            i += 1;
        };

        moves
    }

}