// Errors

mod errors {
    //const COLOR_INVALID_VALUE: felt252 = 'Color: invalid value';
}


#[derive(Serde, Copy, Drop, PartialEq, Introspect)]
enum ProfilePicType {
    Undefined,  // 0
    Native,    // 1
    External,   // 2
    // StarkId,    // stark.id (ipfs?)
    // ERC721,     // Owned erc-721 (hard to validate and keep up to date)
    // Discord,    // Linked account (had to be cloned, or just copy the url)
}