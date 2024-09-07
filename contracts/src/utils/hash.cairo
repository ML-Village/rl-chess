use traits::Into;

// https://github.com/starkware-libs/cairo/blob/main/corelib/src/integer.cairo
// https://github.com/smartcontractkit/chainlink-starknet/blob/develop/contracts/src/utils.cairo
use integer::{u128s_from_felt252, U128sFromFelt252Result};

// https://github.com/starkware-libs/cairo/blob/main/corelib/src/pedersen.cairo
// externals usage:
// https://github.com/shramee/starklings-cairo1/blob/main/corelib/src/hash.cairo
extern fn pedersen(a: felt252, b: felt252) -> felt252 implicits(Pedersen) nopanic;

//
// initially hash based on: 
// https://github.com/shramee/cairo-random/blob/main/src/hash.cairo

fn hash_felt(seed: felt252, offset: felt252) -> felt252 {
    pedersen(seed, offset)
}

fn hash_u128(seed: u128, offset: u128) -> u128 {
    let hash = hash_felt(seed.into(), offset.into());
    felt_to_u128(hash)
}

fn felt_to_u128(value: felt252) -> u128 {
    match u128s_from_felt252(value) {
        U128sFromFelt252Result::Narrow(x) => x,
        U128sFromFelt252Result::Wide((_, x)) => x,
    }
}

// upgrade a u128 hash to u256
fn hash_u128_to_u256(value: u128) -> u256 {
    u256 {
        low: value,
        high: hash_u128(value, value)
    }
}


//----------------------------------------
// Unit  tests
//
#[cfg(test)]
mod tests {
    
}
