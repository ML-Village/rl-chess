use traits::Into;

// https://github.com/starkware-libs/cairo/blob/main/corelib/src/integer.cairo
// https://github.com/smartcontractkit/chainlink-starknet/blob/develop/contracts/src/utils.cairo
use integer::{u128s_from_felt252, U128sFromFelt252Result, u32_to_felt252};

// https://github.com/starkware-libs/cairo/blob/main/corelib/src/pedersen.cairo
// externals usage:
// https://github.com/shramee/starklings-cairo1/blob/main/corelib/src/hash.cairo
extern fn pedersen(a: felt252, b: felt252) -> felt252 implicits(Pedersen) nopanic;

use core::sha256::compute_sha256_byte_array;

fn hash_byte_array(data: @ByteArray) -> [u32; 8] {
    compute_sha256_byte_array(data)
}

fn hash_byte_array_to_felt252(data: @ByteArray) -> felt252 {
    let [a,b,c,d,e,f,g,h] = hash_byte_array(data);
    
    let mut result: felt252 = 0;
    result = result * 0x100000000_felt252 + u32_to_felt252(a);
    result = result * 0x100000000_felt252 + u32_to_felt252(b);
    result = result * 0x100000000_felt252 + u32_to_felt252(c);
    result = result * 0x100000000_felt252 + u32_to_felt252(d);
    result = result * 0x100000000_felt252 + u32_to_felt252(e);
    result = result * 0x100000000_felt252 + u32_to_felt252(f);
    result = result * 0x100000000_felt252 + u32_to_felt252(g);
    result = result * 0x100000000_felt252 + u32_to_felt252(h);
    
    result
}

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
