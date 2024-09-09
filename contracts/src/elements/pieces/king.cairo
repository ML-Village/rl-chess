// Core imports

use core::debug::PrintTrait;

// Internal imports
use rl_chess::types::piece::{Piece};
use rl_chess::elements::pieces::interface::PieceTrait;
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::helpers::from_to::FROM_TO_VEC;
use rl_chess::models::board::Board;
use rl_chess::utils::bitboard::{
    piece_at, color_at, 
    Magic, generate_rook_masks, generate_sliding_moves,
    is_square_attacked
};
use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::constants::{FILE_A, FILE_H, RANK_1, RANK_8};

mod errors {
    const BOARD_NO_PIECE_TO_MOVE: felt252 = 'Board: no piece to move';
}

impl King of PieceTrait {
    #[inline]
    fn can(board: Board, from: u8, to: u8) -> bool {
        // [Check] The new position is a valid one
        let possible_moves = KingImpl::generate_possible_king_moves(from, board);

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
impl KingImpl of KingTrait {
    
    #[inline]
    fn generate_possible_king_moves(from:u8, board: Board) -> Array<FROM_TO_VEC> {
        let mut moves: Array<FROM_TO_VEC> = array![];
        let friendly_pieces = King::friendly_occupied(from, board);

        // King move offsets
        let offsets: Array<(i8, i8)> = array![
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),           (0, 1),
            (1, -1),  (1, 0),  (1, 1)
        ];

        let from_row = from / 8;
        let from_col = from % 8;

        let mut i = 0;
        loop {
            if i == offsets.len() {
                break;
            }
            let (row_offset, col_offset) = *offsets[i];
            
            let to_row = (from_row.try_into().unwrap()  + row_offset).try_into().unwrap_or(88_u8);
            let to_col = (from_col.try_into().unwrap() + col_offset).try_into().unwrap_or(88_u8);

            if to_row < 8 && to_col < 8 {
                let to = to_row * 8 + to_col;
                let to_bitboard = Bitmap::set_bit_at(0, to, true);

                if to_bitboard & friendly_pieces == 0 {

                    // TODO: check if king is in check at to-square
                    moves.append(FROM_TO_VEC { from, to });
                }
            }

            i += 1;
        };


        // Castling moves (do they check if squares are attacked etc?)
        if Self::can_castle_kingside(board) {
            let kingside_to = if board.side_to_move == Color::White { 6 } else { 62 };
            moves.append(
                FROM_TO_VEC { from, to: kingside_to }
            );
        }
        if Self::can_castle_queenside(board) {
            let queenside_to = if board.side_to_move == Color::White { 2 } else { 58 };
            moves.append(
                FROM_TO_VEC { from, to: queenside_to }
            );
        }

        moves
    }

    #[inline]
    fn can_castle_kingside(board: Board) -> bool {
        let side_to_move = board.side_to_move;
        let castling_rights = board.castling_rights;

        let (king_square, rook_square, empty_squares, rights_mask) = match side_to_move {
            Color::White => (4, 7, 0x60, 0b1000),
            Color::Black => (60, 63, 0x6000000000000000, 0b0010),
            _ => (0, 0, 0, 0),
        };
        castling_rights & rights_mask != 0
            && piece_at(board, king_square) == Option::Some(Piece::King) // king is there
            && piece_at(board, rook_square) == Option::Some(Piece::Rook) // rook is there
            && (board.whites | board.blacks) & empty_squares == 0 // no pieces in between
            && !is_square_attacked(board, king_square, side_to_move.opposite()) // king is not attacked
            && !is_square_attacked(board, king_square + 1, side_to_move.opposite()) // king's path is not attacked
    }

    fn can_castle_queenside(board: Board) -> bool {
        let side_to_move = board.side_to_move;
        let castling_rights = board.castling_rights;

        let (king_square, rook_square, empty_squares, rights_mask) = match side_to_move {
            Color::White => (4, 0, 0x0E, 0b0100),
            Color::Black => (60, 56, 0x0E00000000000000, 0b0001),
            _ => (0, 0, 0, 0),
        };
        castling_rights & rights_mask != 0
            && piece_at(board, king_square) == Option::Some(Piece::King) // king is there
            && piece_at(board, rook_square) == Option::Some(Piece::Rook) // rook is there
            && (board.whites | board.blacks) & empty_squares == 0 // no pieces in between
            && !is_square_attacked(board, king_square, side_to_move.opposite()) // king is not attacked
            && !is_square_attacked(board, king_square - 1, side_to_move.opposite()) // king's path is not attacked
    }

}