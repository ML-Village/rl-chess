// Core imports

use core::debug::PrintTrait;
use core::array::ArrayTrait;
use traits::{Into, TryInto};

use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::models::board::Board;
use rl_chess::types::piece::Piece;
use rl_chess::types::color::Color;
use rl_chess::helpers::from_to::FROM_TO_VEC;

pub fn piece_at(board: Board, square: u8) -> Option<Piece> {
    if Bitmap::get_bit_at(board.pawns, square) { return Option::Some(Piece::Pawn); }
    if Bitmap::get_bit_at(board.rooks, square) { return Option::Some(Piece::Rook); }
    if Bitmap::get_bit_at(board.knights, square) { return Option::Some(Piece::Knight); }
    if Bitmap::get_bit_at(board.bishops, square) { return Option::Some(Piece::Bishop); }
    if Bitmap::get_bit_at(board.queens, square) { return Option::Some(Piece::Queen); }
    if Bitmap::get_bit_at(board.kings, square) { return Option::Some(Piece::King); }
    Option::None
}


pub fn color_at(board: Board, square: u8) -> Option<Color> {
    if Bitmap::get_bit_at(board.whites, square) { return Option::Some(Color::White); }
    if Bitmap::get_bit_at(board.blacks, square) { return Option::Some(Color::Black); }
    Option::None
}

#[derive(Copy, Drop, Serde)]
struct Magic {
    mask: u64,
    magic: u64,
    shift: u8,
    offset: u32,
}

pub fn find_magic_number(mask: u64, shift: u8) -> u64 {
    let mut rng = 0x1234567890ABCDEF_u64; // Simple random number generator
    loop {
        let magic = rng & 0xFFFFFFFFFFFFFF00 | 1;
        if (((mask * magic) / Bitmap::set_bit_at(0, 56, true)) & 0xFF) == 0xFF {
            break magic;
        }
        rng = rng * 6364136223846793005 + 1;
    }
}

pub fn count_ones(mut n: u64) -> u8 {
    let mut count: u8 = 0;
    loop {
        if n == 0 {
            break;
        }
        count += 1;
        n = n & (n - 1);
    };
    count
}

pub fn generate_rook_masks() -> Array<u64> {
    let mut masks: Array<u64> = ArrayTrait::new();
    let mut square: u8 = 0;
    loop {
        if square == 64 {
            break;
        }
        let file = square % 8;
        let rank = square / 8;
        let mut mask: u64 = 0;

        // Generate mask for current square
        let mut r = rank + 1;
        loop {
            if r == 7 {
                break;
            }
            mask = mask | Bitmap::set_bit_at(0, (r * 8 + file), true);
            r += 1;
        };

        let mut r = rank - 1;
        loop {
            if r == 0 {
                break;
            }
            mask = mask | Bitmap::set_bit_at(0, (r * 8 + file), true);
            r -= 1;
        };

        let mut f = file + 1;
        loop {
            if f == 7 {
                break;
            }
            mask = Bitmap::set_bit_at(0, (rank * 8 + f),true);
            f += 1;
        };

        let mut f = file - 1;
        loop {
            if f == 0 {
                break;
            }
            mask = mask | Bitmap::set_bit_at(0, (rank * 8 + f),true);
            f -= 1;
        };

        masks.append(mask);
        square += 1;
    };
    masks
}

pub fn generate_rook_magics() -> Array<Magic> {
    let masks = generate_rook_masks();
    let mut magics: Array<Magic> = ArrayTrait::new();
    let mut offset = 0_u32;

    let mut i = 0;
    loop {
        if i == 64 {
            break;
        }
        let mask = *masks.at(i);
        let shift = (64 - count_ones(mask)).into();
        let magic = find_magic_number(mask, shift);
        magics.append(
            Magic { mask, magic, shift, offset }
        );
        offset += Bitmap::set_bit_at(0, (64 - shift), true);
        i += 1;
    };
    magics
}

pub fn generate_bishop_masks() -> Array<u64> {
    let mut masks: Array<u64> = ArrayTrait::new();
    let mut square: u8 = 0;
    loop {
        if square == 64 {
            break;
        }
        let file = square % 8;
        let rank = square / 8;
        let mut mask: u64 = 0;

        // Generate mask for current square
        let mut r = rank + 1;
        let mut f = file + 1;
        loop {
            if r == 7 || f == 7 {
                break;
            }
            mask = mask | Bitmap::set_bit_at(0, (r * 8 + f), true);
            r += 1;
            f += 1;
        };

        r = rank + 1;
        f = file - 1;
        loop {
            if r == 7 || f == 0 {
                break;
            }
            mask = mask | Bitmap::set_bit_at(0, (r * 8 + f), true);
            r += 1;
            f -= 1;
        };

        r = rank - 1;
        f = file + 1;
        loop {
            if r == 0 || f == 7 {
                break;
            }
            mask = mask | Bitmap::set_bit_at(0, (r * 8 + f), true);
            r -= 1;
            f += 1;
        };

        r = rank - 1;
        f = file - 1;
        loop {
            if r == 0 || f == 0 {
                break;
            }
            mask = mask | Bitmap::set_bit_at(0, (r * 8 + f), true);
            r -= 1;
            f -= 1;
        };

        masks.append(mask);
        square += 1;
    };
    masks
}

pub fn generate_bishop_magics() -> Array<Magic> {
    let masks = generate_bishop_masks();
    let mut magics: Array<Magic> = ArrayTrait::new();
    let mut offset = 0_u32;

    let mut i = 0;
    loop {
        if i == 64 {
            break;
        }
        let mask = *masks.at(i);
        let shift = (64 - count_ones(mask)).into();
        let magic = find_magic_number(mask, shift);
        magics.append(
            Magic { mask, magic, shift, offset }
        );
        offset += Bitmap::set_bit_at(0, (64 - shift), true);
        i += 1;
    };
    magics
}

pub fn wrapping_mul_u64(a: u64, b: u64) -> u64 {
    let result: u128 = a.into() * b.into();
    (result & 0xFFFFFFFFFFFFFFFF_u128).try_into().unwrap()
}

// fn generate_sliding_moves(from:u8, board:Board, directions:Array<i8>) -> Array<FROM_TO_VEC> {
//     let mut moves: Array<FROM_TO_VEC> = array![];
//     let from_piece = piece_at(board, from);
//     let from_color = color_at(board, from);

//     assert(from_piece != Option::None && from_color != Option::None, 'Board: no piece to move');
//     let from_piece = from_piece.unwrap();
//     //let from_color = from_color.unwrap();

//     let occupied = (board.whites | board.blacks);

//     let ROOK_MASKS: Array<u64> = generate_rook_masks();

//     let ROOK_MAGICS: Array<Magic> = generate_rook_magics();

//     let BISHOP_MASKS: Array<u64> = generate_bishop_masks();

//     let BISHOP_MAGICS: Array<Magic> = generate_bishop_magics();

//     let (magic, mask) : (Magic, u64) = match from_piece {
//         Piece::Bishop => (*BISHOP_MAGICS[from.into()], *BISHOP_MASKS[from.into()]),
//         Piece::Rook => (*ROOK_MAGICS[from.into()], *ROOK_MASKS[from.into()]),
//         _ => (Magic { mask: 0, magic: 0, shift: 0, offset: 0 }, 0),
//     };

//     let index = (wrapping_mul_u64(occupied & mask, magic.factor) / Bitmap::set_bit_at(0, magic.shift, true));
    
//     let move_bitboard = magic.moves[index.into()] & !self.colors[self.side_to_move.into()];
    
    
//     moves
// }
pub fn generate_sliding_moves(from: u8, board: Board) -> Array<FROM_TO_VEC> {
    let mut moves: Array<FROM_TO_VEC> = ArrayTrait::new();
    let from_piece = piece_at(board, from).unwrap();
    let from_color = color_at(board, from).unwrap();

    let occupied = board.whites | board.blacks;

    // Define directions for rook and bishop
    let rook_directions = array![1, -1, 8, -8];
    let bishop_directions = array![7, -7, 9, -9];

    let directions = match from_piece {
        Piece::Rook => rook_directions,
        Piece::Bishop => bishop_directions,
        Piece::Queen => {
            let mut queen_directions = ArrayTrait::new();
            let mut i = 0;
            loop {
                if i == rook_directions.len() + bishop_directions.len() {
                    break;
                }
                if i < rook_directions.len() {
                    queen_directions.append(*rook_directions.at(i));
                } else {
                    queen_directions.append(*bishop_directions.at(i - rook_directions.len()));
                }
                i += 1;
            };
            queen_directions
        },
        _ => panic_with_felt252('Invalid sliding piece')
    };

    let mut i = 0;
    loop {
        if i == directions.len() {
            break;
        }
        let direction = *directions.at(i);
        let mut to = from;
        loop {
            to = (to.into() + direction).try_into().unwrap();
            if to >= 64 || (to % 8 == 0 && direction == -1) || (to % 8 == 7 && direction == 1) {
                break; // Off the board or wrapped around
            }
            moves.append(FROM_TO_VEC { from, to });
            if Bitmap::get_bit_at(occupied, to) {
                if color_at(board, to) != Option::Some(from_color) {
                    // Capture move is already appended
                }
                break; // Blocked by a piece
            }
        };
        i += 1;
    };

    moves
}