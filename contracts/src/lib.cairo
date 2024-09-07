mod constants;
mod store;

mod types {
    mod profile;
    mod color;
}

mod models {
    mod index;
    mod player;
}

mod components {
    mod playable;
}

mod systems {
    mod lobby;
}

mod elements {
    mod modes {
        mod interface;
    }
    mod pieces {
        mod interface;
    }
}

mod helpers {
    mod seeder;
}

mod utils {
    mod bitwise;
    mod hash;
    mod math;
    mod short_string;
    mod timestamp;
}

#[cfg(test)]
mod tests {
    
}
