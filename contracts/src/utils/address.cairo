use core::traits::Into;
use core::integer::u256_from_felt252;
use core::option::OptionTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use core::byte_array::{ByteArray, ByteArrayTrait};

const ADDRESS_STRING_LENGTH: usize = 66; // '0x' + 64 hex characters

fn address_to_string(address: ContractAddress) -> Array<felt252> {
    let mut result: Array<felt252> = ArrayTrait::new();
    result.append('0x');

    let address_felt: felt252 = address.into();
    let address_u256: u256 = u256_from_felt252(address_felt);

    let mut i: usize = 64;
    loop {
        if i == 0 {
            break;
        }
        i -= 1;
        let digit = (address_u256 / u256_from_felt252(pow(16, i.into())) % 16).try_into().unwrap();
        let char = digit_to_char(digit);
        result.append(char);
    };

    result
}

fn address_to_byte_array(address: ContractAddress) -> ByteArray {
    let address_felt: felt252 = address.into();
    let address_u256: u256 = u256_from_felt252(address_felt);

    let mut byte_array: ByteArray = Default::default();

    // ContractAddress is 32 bytes (256 bits)
    let mut i: usize = 32;
    loop {
        if i == 0 {
            break;
        }
        i -= 1;
        let byte = ((address_u256 / u256_pow(256, i.into())) % 256_u256).try_into().unwrap();
        byte_array.append_byte(byte);
    };

    byte_array
}

fn address_to_string_literal(address: ContractAddress) -> Array<felt252> {
    let mut result: Array<felt252> = ArrayTrait::new();
    result.append('0');
    result.append('x');

    let address_felt: felt252 = address.into();
    let address_u256: u256 = u256_from_felt252(address_felt);

    let mut i: usize = 64;
    loop {
        if i == 0 {
            break;
        }
        i -= 1;
        let digit = (address_u256 / u256_pow(16, i.into()) % 16).try_into().unwrap();
        let char = digit_to_char(digit);
        result.append(char);
    };

    assert(result.len() == ADDRESS_STRING_LENGTH, 'Invalid address length');
    result
}

fn digit_to_char(digit: u8) -> felt252 {
    if digit < 10 {
        ('0' + digit).into()
    } else {
        ('a' + (digit - 10)).into()
    }
}

// Add this new function
fn u256_pow(base: u256, exp: u256) -> u256 {
    if exp == 0_u256 {
        1_u256
    } else {
        base * u256_pow(base, exp - 1_u256)
    }
}

fn pow(base: felt252, exp: felt252) -> felt252 {
    if exp == 0 {
        1
    } else {
        base * pow(base, exp - 1)
    }
}