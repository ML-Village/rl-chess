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