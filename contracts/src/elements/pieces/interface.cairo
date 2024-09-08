use rl_chess::helpers::from_to::FROM_TO_VEC;
use rl_chess::models::board::Board;


trait PieceTrait {

    //  (origin: starter-chess)  can move (valid move)
    fn can(board: Board, from: u8, to: u8) -> bool;
    
    fn friendly_occupied(from: u8, board: Board) -> u64;
}

