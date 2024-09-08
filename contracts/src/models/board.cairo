// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};


// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::Board;
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::types::piece::{Piece, PieceTrait};
use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::utils::bitboard::{piece_at, color_at};
use rl_chess::constants;

mod errors {
    const BOARD_INVALID_PIECE: felt252 = 'Board: invalid piece';
    const BOARD_INVALID_COLOR: felt252 = 'Board: invalid color';
    const BOARD_INVALID_SQUARE: felt252 = 'Board: invalid square';
    const BOARD_INVALID_PIECE_NONE_INPUT: felt252 = 'Board: invalid piece-none input';
    const BOARD_NO_PIECE_TO_MOVE: felt252 = 'Board: no piece to move';
    const BOARD_FRIENDLY_PIECE_AT_DESTINATION: felt252 = 'Board: frenly piece at destn';
    const BOARD_INVALID_MOVE: felt252 = 'Board: invalid move';
}

#[generate_trait]
impl BoardImpl of BoardTrait {
    
    #[inline]
    fn new(game_id: u128) -> Board {

        Board {
            game_id,
            whites: constants::DEFAULT_WHITE_POSITIONS,
            blacks: constants::DEFAULT_BLACK_POSITIONS,

            pawns: constants::DEFAULT_PAWN_POSITIONS,
            rooks: constants::DEFAULT_ROOK_POSITIONS,
            knights: constants::DEFAULT_KNIGHT_POSITIONS,
            bishops: constants::DEFAULT_BISHOP_POSITIONS,
            queens: constants::DEFAULT_QUEEN_POSITIONS,
            kings: constants::DEFAULT_KING_POSITIONS,

            side_to_move: Color::None,
            castling_rights: 0b1111,
            en_passant: 88, // 88 is the square index for "no square"
            halfmove_clock: 0,
            fullmove_number: 1,
            last_move_time: get_block_timestamp(),
        }
    }

    #[inline]
    fn set_piece(ref self: Board, piece: Piece, color: Color, square: u8) {
        
        // if one of color or piece is none, both must be none
        if (color == Color::None || piece == Piece::None) {
            assert(color == Color::None && piece == Piece::None, errors::BOARD_INVALID_PIECE_NONE_INPUT);
        }

        assert(square < 64, errors::BOARD_INVALID_SQUARE);

        //let bit = 1_u64 << square;
        //self.pieces[piece] = Bitmap::set_bit_at(; // set the bit for the piece type
        // self.colors[color] |= bit; // set the bit for the color

        // set piece bitboard and set color bitboard
        match piece {
            Piece::None => { self.pawns = Bitmap::set_bit_at(self.pawns, square, false); },
            Piece::Pawn => { self.pawns = Bitmap::set_bit_at(self.pawns, square, true); },
            Piece::Rook => { self.rooks = Bitmap::set_bit_at(self.rooks, square, true); },
            Piece::Knight => { self.knights = Bitmap::set_bit_at(self.knights, square, true); },
            Piece::Bishop => { self.bishops = Bitmap::set_bit_at(self.bishops, square, true); },
            Piece::Queen => { self.queens = Bitmap::set_bit_at(self.queens, square, true); },
            Piece::King => { self.kings = Bitmap::set_bit_at(self.kings, square, true); },
        };

        match color {
            Color::None => { 
                    self.whites = Bitmap::set_bit_at(self.whites, square, false); 
                    self.blacks = Bitmap::set_bit_at(self.blacks, square, false); 
                },
            Color::White => { self.whites = Bitmap::set_bit_at(self.whites, square, true); },
            Color::Black => { self.blacks = Bitmap::set_bit_at(self.blacks, square, true); },
        };

    }

    #[inline]
    fn piece_at(ref self: Board, square: u8) -> Option<Piece> {
        piece_at(self, square)
    }

    #[inline]
    fn color_at(ref self: Board, square: u8) -> Option<Color> {
        color_at(self, square)
    }

    // this is just for general moving without checking for legalities
    // the proper move would be in the system so that there can be other type of games using this Board model
    #[inline]
    fn move_piece(ref self: Board, from: u8, to: u8) {
        // [Check] if there is a piece to move from
        let piece_from = self.piece_at(from);
        let color_from = self.color_at(from);

        assert(piece_from != Option::None && color_from != Option::None, errors::BOARD_NO_PIECE_TO_MOVE);

        // let bitmap_of_piece_from: u64 = match piece_from {
        //     Option::None => 0,
        //     Option::Some(piece) => match piece {
        //         Piece::None => 0,
        //         Piece::Pawn => self.pawns,
        //         Piece::Rook => self.rooks,
        //         Piece::Knight => self.knights,
        //         Piece::Bishop => self.bishops,
        //         Piece::Queen => self.queens,
        //         Piece::King => self.kings,
        //     },
        // };

        // [Check] if there is no piece at the destination that is of similar color
        //let piece_to = self.piece_at(to);
        let color_to = self.color_at(to);

        assert(color_to != color_from, errors::BOARD_FRIENDLY_PIECE_AT_DESTINATION);

        // [Check] if move is within piece's move range
        let piece_can_move = piece_from.unwrap().can(self, from, to);

        assert(piece_can_move, errors::BOARD_INVALID_MOVE);

        // not checking move legality rules as we leave them to their systems to implement

        // [Action] move the piece
        self.set_piece(piece_from.unwrap(), color_from.unwrap(), to); // set piece at destination
        self.set_piece(Piece::None, color_from.unwrap(), from); // remove piece

        // set side to move next
        self.side_to_move = self.side_to_move.next();
    }

    

}