// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};

// 1. check if all board assigns only affect main board states that are legit
// 2. System contract takes care of starting game and ending game (with check on draw etc)
// 3. Slowly migrate functions that are game rules based to system contract and leave only plain piece rules here
// Note TODO: .try_into().unwrap_or(88_u8); (check if some unwraps fail)
// 4. check if king is in check 

// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::Board;
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::types::piece::{Piece, PieceTrait, IntoU8Piece};
use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::utils::bitboard::{piece_at, color_at};
use rl_chess::utils::math::{MathTrait, MathU8};
use rl_chess::constants;

mod errors {
    const BOARD_INVALID_PIECE: felt252 = 'Board: invalid piece';
    const BOARD_INVALID_COLOR: felt252 = 'Board: invalid color';
    const BOARD_INVALID_SQUARE: felt252 = 'Board: invalid square';
    const BOARD_INVALID_PIECE_NONE_INPUT: felt252 = 'Board: invalid piece-none input';
    const BOARD_NO_PIECE_TO_MOVE: felt252 = 'Board: no piece to move';
    const BOARD_FRIENDLY_PIECE_AT_DESTINATION: felt252 = 'Board: frenly piece at destn';
    const BOARD_INVALID_MOVE: felt252 = 'Board: invalid move';
    const BOARD_INVALID_PROMOTION: felt252 = 'Board: invalid promotion';
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

            wcp: 0,
            wcr: 0,
            wck: 0,
            wcb: 0,
            wcq: 0,

            bcp: 0,
            bcr: 0,
            bck: 0,
            bcb: 0,
            bcq: 0,
            
            side_to_move: Color::None,
            castling_rights: 0b1111,
            en_passant: 88, // 88 is the square index for "no square"
            halfmove_clock: 0,
            fullmove_number: 1,
            last_move_time: 0
        }
    }

    #[inline]
    fn start_board(ref self: Board) {
        self.side_to_move = Color::White;
        self.last_move_time = get_block_timestamp();
    }

    #[inline]
    fn to_fen(ref self: Board) -> ByteArray {
        let mut fen: ByteArray = "";

        // 1. Piece placement
        for rank in array![7,6,5,4,3,2,1,0].span() {
            let mut empty_count:u8 = 0;
            for file in array![0,1,2,3,4,5,6,7].span() {
                let square: u8 = ((*rank) * 8) + (*file);
                let piece = self.piece_at(square);
                let color = self.color_at(square);
                if (piece.is_some() && color.is_some()) {
                    if empty_count > 0 {
                        fen += format!("{empty_count}");
                        empty_count = 0;
                    }

                    let symbol = match (piece.unwrap(), color.unwrap()){
                        (Piece::Pawn, Color::White) => "P",
                        (Piece::Rook, Color::White) => "R",
                        (Piece::Knight, Color::White) => "N",
                        (Piece::Bishop, Color::White) => "B",
                        (Piece::Queen, Color::White) => "Q",
                        (Piece::King, Color::White) => "K",
                        (Piece::Pawn, Color::Black) => "p",
                        (Piece::Rook, Color::Black) => "r",
                        (Piece::Knight, Color::Black) => "n",
                        (Piece::Bishop, Color::Black) => "b",
                        (Piece::Queen, Color::Black) => "q",
                        (Piece::King, Color::Black) => "k",
                        _ => "", // suppose to increment empty count
                    };
                    fen += symbol;
                } else {
                    empty_count += 1;
                };
            };
            if empty_count > 0 {
                fen += format!("{empty_count}");
            };
            if (*rank) > 0 {
                fen += "/";
            };
        };

        // 2. Active color
        fen += " ";
        match self.side_to_move {
            Color::White => fen += "w",
            Color::Black => fen += "b",
            _ => {
                assert(false, errors::BOARD_INVALID_COLOR);
            },
        };
        
        // 3. Castling availability
        fen += " ";
        let mut castling: ByteArray = "";
        if self.castling_rights == 0 {
            fen += "-";
        } else {
            
            if self.castling_rights & 0b1000 != 0 { castling +="K"; }
            if self.castling_rights & 0b0100 != 0 { castling += "Q"; }
            if self.castling_rights & 0b0010 != 0 { castling += "k"; }
            if self.castling_rights & 0b0001 != 0 { castling += "q"; }
            fen += castling;
        };
        
        // 4. En passant target square              
        fen += " ";
        if self.en_passant == 88 {  
            fen += "-";
        } else {
            //let file: felt252 = ((self.en_passant % 8).into() + 'a'); // 97 is the ascii value for 'a'
            let file: ByteArray = match self.en_passant % 8 {
                0 => "a",
                1 => "b",
                2 => "c",
                3 => "d",
                4 => "e",
                5 => "f",
                6 => "g",
                7 => "h",
                _ => "",
            };
            let rank: u8 = ((self.en_passant / 8) + 1);
            fen += file;
            fen += format!("{}", rank);
        };

        // 5. Halfmove clock
        fen += format!(" {}",self.halfmove_clock);

        // 6. Fullmove number
        fen += format!(" {}",self.fullmove_number);

        return fen; // return snapshot?
    }

    #[inline]
    fn set_side_to_move(ref self: Board, side: Color) {
        self.side_to_move = side;
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

        // 1. set piece bitboard
        match piece {
            Piece::None => { 
                self.pawns = Bitmap::set_bit_at(self.pawns, square, false); 
                self.rooks = Bitmap::set_bit_at(self.rooks, square, false); 
                self.knights = Bitmap::set_bit_at(self.knights, square, false); 
                self.bishops = Bitmap::set_bit_at(self.bishops, square, false); 
                self.queens = Bitmap::set_bit_at(self.queens, square, false); 
                self.kings = Bitmap::set_bit_at(self.kings, square, false); 
            },
            Piece::Pawn => { self.pawns = Bitmap::set_bit_at(self.pawns, square, true); },
            Piece::Rook => { self.rooks = Bitmap::set_bit_at(self.rooks, square, true); },
            Piece::Knight => { self.knights = Bitmap::set_bit_at(self.knights, square, true); },
            Piece::Bishop => { self.bishops = Bitmap::set_bit_at(self.bishops, square, true); },
            Piece::Queen => { self.queens = Bitmap::set_bit_at(self.queens, square, true); },
            Piece::King => { self.kings = Bitmap::set_bit_at(self.kings, square, true); },
        };

        // 2. set color bitboard
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

    #[inline]
    fn update_castling_rights(ref self: Board, from: u8, to: u8) {
        // Remove castling rights if king or rook moves
        if from == 0 || to == 0 { self.castling_rights = 0b1110; } // White queenside
        if from == 7 || to == 7 { self.castling_rights = 0b1101; } // White kingside
        if from == 56 || to == 56 { self.castling_rights = 0b1011; } // Black queenside
        if from == 63 || to == 63 { self.castling_rights = 0b0111; } // Black kingside
        if from == 4 { self.castling_rights = 0b1100; } // White king
        if from == 60 { self.castling_rights = 0b0011; } // Black king
    }

    #[inline]
    fn print_board(ref self: Board) {
        println!("  a b c d e f g h");
        println!(" +-+-+-+-+-+-+-+-+");
        // loop through 8 ranks
        for rank in array![7,6,5,4,3,2,1,0].span() {
            print!("{}|", *rank + 1);
            for file in array![0,1,2,3,4,5,6,7].span() {
                let square: u8 = ((*rank) * 8) + (*file);
                let piece = self.piece_at(square);
                let color = self.color_at(square);
                match (piece, color ) {
                    (Option::Some(p), Option::Some(c)) => {
                        match (p, c) {
                            (Piece::Pawn, Color::White) => print!("P|"),
                            (Piece::Rook, Color::White) => print!("R|"),
                            (Piece::Knight, Color::White) => print!("N|"),
                            (Piece::Bishop, Color::White) => print!("B|"),
                            (Piece::Queen, Color::White) => print!("Q|"),
                            (Piece::King, Color::White) => print!("K|"),
                            (Piece::Pawn, Color::Black) => print!("p|"),
                            (Piece::Rook, Color::Black) => print!("r|"),
                            (Piece::Knight, Color::Black) => print!("n|"),
                            (Piece::Bishop, Color::Black) => print!("b|"),
                            (Piece::Queen, Color::Black) => print!("q|"),
                            (Piece::King, Color::Black) => print!("k|"),
                            _ => print!(" |"),
                        }
                    },
                    _ => {print!(" |");},
                };
            };
            println!(" {}", *rank + 1);
            println!(" +-+-+-+-+-+-+-+-+");
        };
        println!("  a b c d e f g h");
        match self.side_to_move {
            Color::White => println!("Side to move: W"),
            Color::Black => println!("Side to move: B"),
            _ => println!("Side to move: None"),
        };
        //println!("Castling rights: {:04b}", self.castling_rights);
        println!("Castling rights: {}", self.castling_rights);
        println!("En passant square: {:?}", self.en_passant);
        println!("Halfmove clock: {}", self.halfmove_clock);
        println!("Fullmove number: {}", self.fullmove_number);
    }

    // this is just for general moving without checking for legalities
    // the proper move would be in the system so that there can be other type of games using this Board model
    #[inline]
    fn move_piece(ref self: Board, from: u8, to: u8, promotion: u8) {
        assert(promotion >1 && promotion <6, errors::BOARD_INVALID_PROMOTION);
        // [Check] if there is a piece to move from
        let mut piece_from = self.piece_at(from);
        let mut color_from = self.color_at(from);

        assert(piece_from != Option::None && color_from != Option::None, 
            errors::BOARD_NO_PIECE_TO_MOVE);
        
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
        let target_piece = self.piece_at(to);
        
        assert(color_to != color_from, 
            errors::BOARD_FRIENDLY_PIECE_AT_DESTINATION); // this also being checked in the subsequent functions

        // [Check] if move is within piece's move range (MAIN MOVE LOGIC)
        // can means: - no obstruction in between (pawn, rook, bishop, queen)
        //            - destination is not friendly (all)
        //          not yet: - destination is not attacked by enemy? ( for king ?)
        let piece_can_move = piece_from.unwrap().can(self, from, to);

        assert(piece_can_move, errors::BOARD_INVALID_MOVE);

        // not checking move legality rules as we leave them to their systems to implement


        // [Action] Handle captured piece (clear target square and track captures)
        match target_piece {
            Option::Some(piece) => {
                match piece {
                    Piece::Pawn => if color_from.unwrap() == Color::White { self.wcp += 1; } else { self.bcp += 1; },
                    Piece::Rook => if color_from.unwrap() == Color::White { self.wcr += 1; } else { self.bcr += 1; },
                    Piece::Knight => if color_from.unwrap() == Color::White { self.wck += 1; } else { self.bck += 1; },
                    Piece::Bishop => if color_from.unwrap() == Color::White { self.wcb += 1; } else { self.bcb += 1; },
                    Piece::Queen => if color_from.unwrap() == Color::White { self.wcq += 1; } else { self.bcq += 1; },
                    _ => {},
                };
                self.set_piece(Piece::None, Color::None, to);
            },
            Option::None => {},
        };

        // Handle pawn promotion
        if piece_from.unwrap() == Piece::Pawn && (to / 8 == 0 || to / 8 == 7) {
            piece_from = Option::Some(IntoU8Piece::into(promotion));
        };
        

        // [Action] move the piece
        self.set_piece(Piece::None, Color::None, from); // remove piece from
        self.set_piece(piece_from.unwrap(), color_from.unwrap(), to); // set piece at destination


        // Handle en passant capture
        if (piece_from.unwrap() == Piece::Pawn) && (to == self.en_passant) {
            let captured_pawn_square: u8 = if self.side_to_move == Color::White { to - 8 } else { to + 8 };

            let mut captured_pawn_color = self.color_at(captured_pawn_square);
            let mut captured_pawn_piece = self.piece_at(captured_pawn_square);

            if (captured_pawn_color.unwrap() == self.side_to_move.opposite()) && (
                captured_pawn_piece.unwrap() == Piece::Pawn) 
            {
                self.set_piece(Piece::None, Color::None, captured_pawn_square);
                match self.side_to_move {
                    Color::White => { self.wcp += 1; },
                    Color::Black => { self.bcp += 1; },
                    _ => {},
                };
            };
        }

        // Update en passant square
        self.en_passant = if (piece_from.unwrap() == Piece::Pawn) && (MathU8::abs(from.try_into().unwrap() - to.try_into().unwrap()) == 16) {
            (from + to) / 2
        } else {
            88
        };

        // Update castling rights
        self.update_castling_rights(from, to);

        
        // set side to move next
        self.side_to_move = self.side_to_move.next();
        self.fullmove_number += 1;

        // Update halfmove clock
        if piece_from.unwrap() == Piece::Pawn || target_piece.is_some() {
            self.halfmove_clock = 0;
        } else {
            self.halfmove_clock += 1;
        }

        // Update position history -- > (THESE WE DO IN SYSTEM AS ARRAY MODEL IN HISTORY)
        // let new_hash = self.calculate_zobrist_hash();
        // self.position_history.push(new_hash);

        // self.last_move = Some((from, to, moving_piece));

        self.last_move_time = get_block_timestamp();

    }

    

}