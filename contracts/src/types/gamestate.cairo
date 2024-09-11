// Errors

mod errors {
    //const COLOR_INVALID_VALUE: felt252 = 'Color: invalid value';
}

#[derive(Copy, Drop, Serde, PartialEq, Introspect)]
enum GameState {
    Null,       // 0  
    Awaiting,   // 1
    Withdrawn,  // 2
    Accepted,    // 3
    Expired,    // 4
    InProgress, // 5
    Resolved,   // 6
    Draw,       // 7
}


impl IntoGameStateFelt252 of core::Into<GameState, felt252> {
    #[inline]
    fn into(self: GameState) -> felt252 {
        match self {
            GameState::Null => 'Null',
            GameState::Awaiting => 'Awaiting',
            GameState::Withdrawn => 'Withdrawn',
            GameState::Accepted => 'Accepted',
            GameState::Expired => 'Expired',
            GameState::InProgress => 'InProgress',
            GameState::Resolved => 'Resolved',
            GameState::Draw => 'Draw',
        }
    }
}

impl IntoGameStateU8 of core::Into<GameState, u8> {
    #[inline]
    fn into(self: GameState) -> u8 {
        match self {
            GameState::Null => 0,
            GameState::Awaiting => 1,
            GameState::Withdrawn => 2,
            GameState::Accepted => 3,
            GameState::Expired => 4,
            GameState::InProgress => 5,
            GameState::Resolved => 6,
            GameState::Draw => 7,
        }
    }
}