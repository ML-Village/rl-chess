// Core imports

use core::debug::PrintTrait;
use traits::{Into, TryInto};

// Internal imports

use rl_chess::helpers::math::Math;
use rl_chess::elements::pieces::interface::PieceTrait;
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::helpers::from_to::FROM_TO_VEC;
use rl_chess::models::board::Board;
use rl_chess::utils::bitboard::{piece_at, color_at};
use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::constants::{FILE_A, FILE_H, RANK_1, RANK_8};

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
        
        let from_bitboard:u64 = Bitmap::set_bit_at(0, from, true);
        
        //Single Push
        let single_push_to_index = if color_from == Color::White { from + 8 } else { from - 8 };

        let to_bitboard:u64 = Bitmap::set_bit_at(0, single_push_to_index, true);
        
        if to_bitboard & ( board.whites | board.blacks ) == 0 {
            moves.append(
                FROM_TO_VEC{
                    from, 
                    to: single_push_to_index
                }
            );

            // Double push from starting rank (this is inside single push to check for empty square infront)
            if (color_from == Color::White && from / 8 == 1) || (color_from == Color::Black && from / 8 == 6) {
                let double_push_to_index = if color_from == Color::White { from + 16 } else { from - 16 };
                let double_to_bitboard = Bitmap::set_bit_at(0, double_push_to_index, true);
                if double_to_bitboard & ( board.whites | board.blacks ) == 0 {
                    moves.append(
                        FROM_TO_VEC{
                            from, 
                            to: double_push_to_index
                        }
                    );
                }
            }

        }

        // Captures
        let capture_bitboard = if color_from == Color::White {
            ((from_bitboard & (0xFFFFFFFFFFFFFFFF_u64 -FILE_A)) * Math::pow(2_u8.into(), 7)) | ((from_bitboard & (0xFFFFFFFFFFFFFFFF_u64 - FILE_H)) * Math::pow(2_u8.into(), 9))
        } else {
            ((from_bitboard & (0xFFFFFFFFFFFFFFFF_u64 -FILE_A)) / Math::pow(2_u8.into(), 9)) | ((from_bitboard & (0xFFFFFFFFFFFFFFFF_u64 - FILE_H)) / Math::pow(2_u8.into(), 7))
        };
        let enemy_pieces = if color_from == Color::White { board.blacks } else { board.whites };
        let captures = capture_bitboard & enemy_pieces;
        
        let mut capture_index: u8 = 0;
        loop {
            if capture_index >= 64 {
                break;
            }
            if (captures & Bitmap::set_bit_at(0, capture_index, true)) != 0 {
                moves.append(
                    FROM_TO_VEC {
                        from,
                        to: capture_index
                    }
                );
            }
            capture_index += 1;
        };

        // En passant captures
        if (board.en_passant != 88) {
            let ep_bitboard = Bitmap::set_bit_at(0, board.en_passant, true);
            if capture_bitboard & ep_bitboard != 0 {
                moves.append(
                    FROM_TO_VEC {
                        from,
                        to: board.en_passant
                    }
                );
            }
        }

        // TODO: Check if need add promotion moves

        moves
    }
}