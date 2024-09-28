// Core imports

use core::debug::PrintTrait;
use core::array::ArrayTrait;
use traits::{Into, TryInto};

use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::models::board::Board;
use rl_chess::types::piece::{Piece, PieceTrait};
use rl_chess::types::color::{Color, ColorTrait};
use rl_chess::helpers::from_to::FROM_TO_VEC;
use rl_chess::constants::{FILE_A, FILE_H, RANK_1, RANK_8,
    DIAGONAL_MASK, ANTI_DIAGONAL_MASK
};

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
    Option::Some(Color::None) //changed at 27/09 1030hrs Sg, see if it fails
}

pub fn is_square_attacked(board: Board, square: u8, by_color: Color) -> bool {
    let square_bb = Bitmap::set_bit_at(0, square, true);
    let enemy_bitboard: u64 = match by_color {
        Color::White => board.whites,
        Color::Black => board.blacks,
        _ => 0,
    };

    let enemy_pawns = board.pawns & enemy_bitboard;
    let enemy_knights = board.knights & enemy_bitboard;
    let enemy_king = board.kings & enemy_bitboard;
    // println!("board_bishops A: {}", board.bishops);
    // println!("board_queens: {}", board.queens);
    // println!("enemy_bitboard: {}", enemy_bitboard);
    let enemy_bishops_queens = (board.bishops | board.queens ) & enemy_bitboard;
    //println!("enemy_bishops_queens: {}", enemy_bishops_queens);
    let enemy_rooks_queens = (board.rooks | board.queens) & enemy_bitboard;
    // println!("enemy_rooks: {}", board.rooks);
    // println!("enemy_rooks_queens: {}", enemy_rooks_queens);
    let occupied = board.whites | board.blacks;

    // Pawn attacks
    let pawn_attacks:u64 = match by_color {
        Color::White => (square_bb / Bitmap::set_bit_at(0,7,true)) & (0xFFFFFFFFFFFFFFFF_u64 - FILE_H) | (square_bb  / Bitmap::set_bit_at(0,9,true)) & (0xFFFFFFFFFFFFFFFF_u64 - FILE_A),
        Color::Black => (square_bb * Bitmap::set_bit_at(0,7,true)) & (0xFFFFFFFFFFFFFFFF_u64 - FILE_A) | (square_bb  * Bitmap::set_bit_at(0,9,true)) & (0xFFFFFFFFFFFFFFFF_u64 - FILE_H),
        _ => 0,
    };
    if pawn_attacks & enemy_pawns != 0 {
        println!("attacked by pawns");
        return true;
    }

    // Knight attacks
    let KNIGHT_MOVES: Array<u64> = generate_knight_moves();
    let knight_moves_at_square = *KNIGHT_MOVES[square.into()];
    if knight_moves_at_square & enemy_knights != 0 {
        //println!("attacked by knights");
        return true;
    }

    // King attacks
    let KING_MOVES: Array<u64> = generate_king_moves();
    let king_moves_at_square = *KING_MOVES[square.into()];
    if king_moves_at_square & enemy_king != 0 {
        //println!("attacked by king");
        return true;
    }

    // Bishop and Queen attacks
    let bishop_attacks = get_bishop_attacks(square, occupied);
    //println!("bishop_attacks: {}", bishop_attacks);
    if bishop_attacks & enemy_bishops_queens != 0 {
        //println!("attacked by bishops");
        return true;
    }

    // Rook and Queen attacks
    let rook_attacks = get_rook_attacks(square, occupied);
    //println!("rook_attacks: {}", rook_attacks);
    //println!("enemy_rooks_queens: {}", enemy_rooks_queens);
    if rook_attacks & enemy_rooks_queens != 0 {
        //println!("attacked by rooks");
        return true;
    }
    false
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

pub fn generate_knight_moves() -> Array<u64> {
    let mut moves: Array<u64> = ArrayTrait::new();
    // iterate through all 0 to 63 squares and generate knight moves for each square
    let mut square = 0;
    loop {
        if square == 64 {
            break;
        }
        let row = square / 8;
        let col = square % 8;
        let mut knight_moves = 0_u64;

        // Define all possible knight move offsets
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
            let new_row = row + row_offset;
            let new_col = col + col_offset;

            if new_row >= 0 && new_row < 8 && new_col >= 0 && new_col < 8 {
                let new_square:u8 = (new_row * 8 + new_col).try_into().unwrap();
                knight_moves = Bitmap::set_bit_at(knight_moves, new_square, true);
            }

            i += 1;
        };

        moves.append(knight_moves);
        square += 1;
    };

    moves
}

fn generate_king_moves() -> Array<u64> {
    let mut moves: Array<u64> = ArrayTrait::new();
    let mut square = 0;
    loop {
        if square == 64 {
            break;
        }
        let row = square / 8;
        let col = square % 8;
        let mut king_moves = 0_u64;

        // Define all possible king move offsets
        let offsets: Array<(i8, i8)> = array![
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),           (0, 1),
            (1, -1),  (1, 0),  (1, 1)
        ];

        let mut i = 0;
        loop {
            if i == offsets.len() {
                break;
            }
            let (row_offset, col_offset) = *offsets[i];
            let new_row = row + row_offset;
            let new_col = col + col_offset;

            if new_row >= 0 && new_row < 8 && new_col >= 0 && new_col < 8 {
                let new_square: u8 = (new_row * 8 + new_col).try_into().unwrap();
                king_moves = Bitmap::set_bit_at(king_moves, new_square, true);
            }

            i += 1;
        };

        moves.append(king_moves);
        square += 1;
    };

    moves
}

// Update these functions to consider occupancy
fn get_bishop_attacks(square: u8, occupied: u64) -> u64 {
    let mut attacks = 0_u64;
    let (row, col) = (square / 8, square % 8);

    // Define the four diagonal directions
    let directions: Array<(i8, i8)> = array![
        (-1, -1), (-1, 1), (1, 1), (1, -1), // left-bot, left-top, right-top, right-bot
    ];

    let mut i = 0;
    loop {
        if i == directions.len() {
            break;
        }
        let (row_dir, col_dir) = *directions[i];
        let mut r: i8 = row.try_into().unwrap() + row_dir;
        let mut c: i8 = col.try_into().unwrap() + col_dir;

        loop {
            if r < 0 || r > 7 || c < 0 || c > 7 {
                break;
            }
            let target_square:u8 = (r * 8 + c).try_into().unwrap();
            attacks = Bitmap::set_bit_at(attacks, target_square, true);

            if Bitmap::get_bit_at(occupied, target_square) {
                break; // Stop if we hit an occupied square
            }

            r += row_dir;
            c += col_dir;
        };

        i += 1;
    };

    attacks
}

fn get_rook_attacks(square: u8, occupied: u64) -> u64 {
    let mut attacks = 0_u64;
    let (row, col) = (square / 8, square % 8);

    // Define the four orthogonal directions
    let directions: Array<(i8, i8)> = array![
        (0, 1), (0, -1), (1, 0), (-1, 0) // up, down, right, left
    ];

    let mut i = 0;
    loop {
        if i == directions.len() {
            break;
        }
        let (row_dir, col_dir) = *directions[i];
        let mut r: i8 = row.try_into().unwrap() + row_dir;
        let mut c: i8 = col.try_into().unwrap() + col_dir;

        loop {
            if r < 0 || r > 7 || c < 0 || c > 7 {
                break;
            }
            let target_square:u8 = (r * 8 + c).try_into().unwrap();
            attacks = Bitmap::set_bit_at(attacks, target_square, true);

            if Bitmap::get_bit_at(occupied, target_square) {
                break; // Stop if we hit an occupied square
            }

            r += row_dir;
            c += col_dir;
        };

        i += 1;
    };

    attacks
}

// old way of getting attacks for bishop and rook (will not check for obstruction)
// fn get_bishop_attacks(square: u8) -> u64 {
//     let file = square % 8;
//     let rank = square / 8;

//     // Diagonal numbering:
//     // There are 15 diagonals on a chess board (8 + 7).
//     // We typically number these diagonals from 0 to 14.
//     // The main diagonal (a1-h8) is usually considered diagonal 7.
//     // The formula 7 + file - rank:
//     // Adding 7: This shifts our numbering so that the main diagonal (a1-h8) becomes 7.
//     // Adding file: As we move right on the board, we increase the diagonal number.
//     // Subtracting rank: As we move up the board, we decrease the diagonal number.

//     // Generate diagonal attacks
//     let diagonal = 7 + file - rank;
//     let diagonal_attacks = DIAGONAL_MASK / Bitmap::set_bit_at(0, (8 * (diagonal & 7)), true);

//     // Generate anti-diagonal attacks
//     let anti_diagonal = file + rank;
//     let anti_diagonal_attacks = ANTI_DIAGONAL_MASK / Bitmap::set_bit_at(0, (8 * (anti_diagonal & 7)), true);

//     // Combine diagonal and anti-diagonal attacks
//     let mut attacks = diagonal_attacks | anti_diagonal_attacks;

//     // Remove the bishop's own square from the attacks
//     attacks = Bitmap::set_bit_at(attacks, square, false);

//     attacks
// }

// fn get_rook_attacks(square: u8) -> u64 {
//     let file = square % 8;
//     let rank = square / 8;

//     // Generate file attacks
//     let file_attacks = FILE_A * Bitmap::set_bit_at(0, file, true);

//     // Generate rank attacks
//     let rank_attacks = RANK_1 * Bitmap::set_bit_at(0, (8 * rank), true);

//     // Combine file and rank attacks
//     let mut attacks = file_attacks | rank_attacks;

//     // Remove the rook's own square from the attacks
//     attacks = Bitmap::set_bit_at(attacks, square, false);

//     attacks
// }

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
    //let from_color = color_at(board, from).unwrap();
    
    // println!("
    // from_piece: {} from_color: {}
    // ", 
    //     from_piece.to_string(), from_color.to_string());

    let occupied = board.whites | board.blacks;

    // Define directions for rook and bishop
    let rook_directions = array![1, -1, 8, -8];
    let bishop_directions = array![7, -7, 9, -9]; // 7 is left diag up, -7 is right diag down etc.

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
        let mut to: i8 = from.try_into().unwrap();
        loop {
            to = to + direction; // check by moving 1 direction unit
            
            if to >= 64 || to < 0 || // off the board
            (to % 8 == 0 && (direction == 1 || direction == -7 || direction == 9)) || // the used direction has already caused left wrap
            (to % 8 == 7 && (direction == -1 || direction == 7 || direction == -9)) { // the used direction has already caused right wrap
                break; // Off the board or wrapped around
            }
            //println!("i: {}, direction: {}, to: {}", i, direction, to);
            let to_square: u8 = to.try_into().unwrap();
            //println!("append");
            moves.append(FROM_TO_VEC { from, to:to_square });

            // check if the square is occupied, if so, it is blocked and we break in this direction
            if Bitmap::get_bit_at(occupied, to_square) {

                // this is option for doing something if it is a capture move
                // if color_at(board, to_square) != Option::Some(from_color) {
                //     // Capture move is already appended
                // }
                break; // Blocked by a piece
            }
        };
        i += 1;
    };

    moves
}