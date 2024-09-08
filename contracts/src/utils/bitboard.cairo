use rl_chess::helpers::bitmap::Bitmap;
use rl_chess::models::board::Board;
use rl_chess::types::piece::Piece;
use rl_chess::types::color::Color;

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
