// Errors

mod errors {
    //const COLOR_INVALID_VALUE: felt252 = 'Color: invalid value';
}

#[derive(Copy, Drop, Serde, PartialEq, Introspect)]
enum InviteState {
    Null,       // 0  
    Awaiting,   // 1
    Withdrawn,  // 2
    Refused,    // 3
    Expired,    // 4
    InProgress, // 5
    Resolved,   // 6
    Draw,       // 7
}