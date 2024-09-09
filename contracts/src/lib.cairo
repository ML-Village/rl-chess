mod constants;
mod store;

mod types {
    mod profile;
    mod color;
    mod piece;
    mod gamestate;
}

mod models {
    mod index;
    mod player;
    mod game;
    mod board;
    mod format;
}

mod components {
    mod playable;
}

mod systems {
    mod admin;
    mod lobby;
}

mod elements {
    mod modes {
        mod interface;
    }
    mod pieces {
        mod interface;
        mod pawn;
        mod knight;
        mod bishop;
        mod rook;
        mod queen;
        mod king;
    }
}

mod helpers {
    mod bitmap;
    mod seeder;
    mod masker;
    mod mapper;
    mod math;
    mod from_to;
}

mod utils {
    mod bitwise;
    mod hash;
    mod math;
    mod short_string;
    mod timestamp;
    mod bitboard;
    mod bitboardIterator;
}

#[cfg(test)]
mod tests {
    
}
