trait PieceTrait {

    //  (origin: starter-chess)  can move (valid move)
    fn can(bitboard: u64, from: u8, to: u8, whites: u64, blacks: u64) -> bool;
}

