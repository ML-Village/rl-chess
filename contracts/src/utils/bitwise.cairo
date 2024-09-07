use traits::Into;

const U8_ONE_LEFT: u8     = 0x80;
const U16_ONE_LEFT: u16   = 0x8000;
const U32_ONE_LEFT: u32   = 0x80000000;
const U64_ONE_LEFT: u64   = 0x8000000000000000;
const U128_ONE_LEFT: u128 = 0x80000000000000000000000000000000;
const U256_ONE_LEFT: u256 = 0x8000000000000000000000000000000000000000000000000000000000000000;

trait Bitwise<T> {
    fn byte_count() -> usize;
    fn bit(n: usize) -> T;
    fn set(x: T, n: usize) -> T;
    fn unset(x: T, n: usize) -> T;
    fn shl(x: T, n: usize) -> T;
    fn shr(x: T, n: usize) -> T;
    fn is_set(x: T, n: usize) -> bool;
    fn count_bits(x: T) -> usize;
    fn sum_bytes(x: T) -> T;
}

impl BitwiseU8 of Bitwise<u8> {
    #[inline(always)]
    fn byte_count() -> usize {(1)}
    fn bit(n: usize) -> u8 {
        if n == 0 { (0b00000001) }
        else if (n == 1) { (0b00000010) }
        else if (n == 2) { (0b00000100) }
        else if (n == 3) { (0b00001000) }
        else if (n == 4) { (0b00010000) }
        else if (n == 5) { (0b00100000) }
        else if (n == 6) { (0b01000000) }
        else if (n == 7) { (0b10000000) }
        else { (0) }
    }
    #[inline(always)]
    fn set(x: u8, n: usize) -> u8 {
        x | Self::bit(n)
    }
    #[inline(always)]
    fn unset(x: u8, n: usize) -> u8 {
        x & ~Self::bit(n)
    }
    #[inline(always)]
    fn shl(x: u8, n: usize) -> u8 {
        x * Self::bit(n)
    }
    #[inline(always)]
    fn shr(x: u8, n: usize) -> u8 {
        if (n < 8) { (x / Self::bit(n)) }
        else { (0) }
    }
    #[inline(always)]
    fn is_set(x: u8, n: usize) -> bool {
        ((Self::shr(x, n) & 1) != 0)
    }
    fn count_bits(x: u8) -> usize {
        let mut result: usize = 0;
        let mut bit: u8 = U8_ONE_LEFT;
        loop {
            if(x & bit > 0) { result += 1; };
            if(bit == 0x1) { break; }
            bit /= 2;
        };
        result
    }
    fn sum_bytes(x: u8) -> u8 {(x)}
}

impl BitwiseU16 of Bitwise<u16> {
    #[inline(always)]
    fn byte_count() -> usize {(2)}
    fn bit(n: usize) -> u16 {
        if n < 8 { (BitwiseU8::bit(n).into()) }
        else if n < 16 { (BitwiseU8::bit(n-8).into() * 0x100) }
        else { (0) }
    }
    #[inline(always)]
    fn set(x: u16, n: usize) -> u16 {
        x | Self::bit(n)
    }
    #[inline(always)]
    fn unset(x: u16, n: usize) -> u16 {
        x & ~Self::bit(n)
    }
    #[inline(always)]
    fn shl(x: u16, n: usize) -> u16 {
        x * Self::bit(n)
    }
    #[inline(always)]
    fn shr(x: u16, n: usize) -> u16 {
        if (n < 16) { (x / Self::bit(n)) }
        else { (0) }
    }
    #[inline(always)]
    fn is_set(x: u16, n: usize) -> bool {
        ((Self::shr(x, n) & 1) != 0)
    }
    fn count_bits(x: u16) -> usize {
        let mut result: usize = 0;
        let mut bit: u16 = U16_ONE_LEFT;
        loop {
            if(x & bit > 0) { result += 1; };
            if(bit == 0x1) { break; }
            bit /= 2;
        };
        result
    }
    fn sum_bytes(mut x: u16) -> u16 {
        let mut result: u16 = 0;
        loop {
            if (x == 0) { break; }
            result += (x & 0xff);
            x /= 0x100;
        };
        (result)
    }
}

impl BitwiseU32 of Bitwise<u32> {
    #[inline(always)]
    fn byte_count() -> usize {(4)}
    fn bit(n: usize) -> u32 {
        if n < 16 { (BitwiseU16::bit(n).into()) }
        else if n < 32 { (BitwiseU16::bit(n-16).into() * 0x10000) }
        else { (0) }
    }
    #[inline(always)]
    fn set(x: u32, n: usize) -> u32 {
        x | Self::bit(n)
    }
    #[inline(always)]
    fn unset(x: u32, n: usize) -> u32 {
        x & ~Self::bit(n)
    }
    #[inline(always)]
    fn shl(x: u32, n: usize) -> u32 {
        x * Self::bit(n)
    }
    #[inline(always)]
    fn shr(x: u32, n: usize) -> u32 {
        if (n < 32) { (x / Self::bit(n)) }
        else { (0) }
    }
    #[inline(always)]
    fn is_set(x: u32, n: usize) -> bool {
        ((Self::shr(x, n) & 1) != 0)
    }
    fn count_bits(x: u32) -> usize {
        let mut result: usize = 0;
        let mut bit: u32 = U32_ONE_LEFT;
        loop {
            if(x & bit > 0) { result += 1; };
            if(bit == 0x1) { break; }
            bit /= 2;
        };
        result
    }
    fn sum_bytes(mut x: u32) -> u32 {
        let mut result: u32 = 0;
        loop {
            if (x == 0) { break; }
            result += (x & 0xff);
            x /= 0x100;
        };
        (result)
    }
}

impl BitwiseU64 of Bitwise<u64> {
    #[inline(always)]
    fn byte_count() -> usize {(8)}
    fn bit(n: usize) -> u64 {
        if n < 32 { (BitwiseU32::bit(n).into()) }
        else if n < 64 { (BitwiseU32::bit(n-32).into() * 0x100000000) }
        else { (0) }
    }
    #[inline(always)]
    fn set(x: u64, n: usize) -> u64 {
        x | Self::bit(n)
    }
    #[inline(always)]
    fn unset(x: u64, n: usize) -> u64 {
        x &  ~Self::bit(n)
    }
    #[inline(always)]
    fn shl(x: u64, n: usize) -> u64 {
        x * Self::bit(n)
    }
    #[inline(always)]
    fn shr(x: u64, n: usize) -> u64 {
        if (n < 64) { (x / Self::bit(n)) }
        else { (0) }
    }
    #[inline(always)]
    fn is_set(x: u64, n: usize) -> bool {
        ((Self::shr(x, n) & 1) != 0)
    }
    fn count_bits(x: u64) -> usize {
        let mut result: usize = 0;
        let mut bit: u64 = U64_ONE_LEFT;
        loop {
            if(x & bit > 0) { result += 1; };
            if(bit == 0x1) { break; }
            bit /= 2;
        };
        result
    }
    fn sum_bytes(mut x: u64) -> u64 {
        let mut result: u64 = 0;
        loop {
            if (x == 0) { break; }
            result += (x & 0xff);
            x /= 0x100;
        };
        (result)
    }
}

impl BitwiseU128 of Bitwise<u128> {
    #[inline(always)]
    fn byte_count() -> usize {(16)}
    fn bit(n: usize) -> u128 {
        if n < 64 { (BitwiseU64::bit(n).into()) }
        else if n < 128 { (BitwiseU64::bit(n-64).into() * 0x10000000000000000) }
        else { (0) }
    }
    #[inline(always)]
    fn set(x: u128, n: usize) -> u128 {
        x | Self::bit(n)
    }
    #[inline(always)]
    fn unset(x: u128, n: usize) -> u128 {
        x & ~Self::bit(n)
    }
    #[inline(always)]
    fn shl(x: u128, n: usize) -> u128 {
        x * Self::bit(n)
    }
    #[inline(always)]
    fn shr(x: u128, n: usize) -> u128 {
        if (n < 128) { (x / Self::bit(n)) }
        else { (0) }
    }
    #[inline(always)]
    fn is_set(x: u128, n: usize) -> bool {
        ((Self::shr(x, n) & 1) != 0)
    }
    fn count_bits(x: u128) -> usize {
        let mut result: usize = 0;
        let mut bit: u128 = U128_ONE_LEFT;
        loop {
            if(x & bit > 0) { result += 1; };
            if(bit == 0x1) { break; }
            bit /= 2;
        };
        result
    }
    fn sum_bytes(mut x: u128) -> u128 {
        let mut result: u128 = 0;
        loop {
            if (x == 0) { break; }
            result += (x & 0xff);
            x /= 0x100;
        };
        (result)
    }
}

impl BitwiseU256 of Bitwise<u256> {
    #[inline(always)]
    fn byte_count() -> usize {(32)}
    fn bit(n: usize) -> u256 {
        if n < 128 { (u256 { low: BitwiseU128::bit(n), high: 0x0 }) }
        else if n < 256 { (u256 { low: 0x0, high: BitwiseU128::bit(n-128) }) }
        else { (0) }
    }
    #[inline(always)]
    fn set(x: u256, n: usize) -> u256 {
        x | Self::bit(n)
    }
    #[inline(always)]
    fn unset(x: u256, n: usize) -> u256 {
        x & ~Self::bit(n)
    }
    #[inline(always)]
    fn shl(x: u256, n: usize) -> u256 {
        x * Self::bit(n)
    }
    #[inline(always)]
    fn shr(x: u256, n: usize) -> u256 {
        if (n < 256) { (x / Self::bit(n)) }
        else { (0) }
    }
    #[inline(always)]
    fn is_set(x: u256, n: usize) -> bool {
        ((Self::shr(x, n) & 1) != 0)
    }
    fn count_bits(x: u256) -> usize {
        let mut result: usize = 0;
        let mut bit: u256 = U256_ONE_LEFT;
        loop {
            if(x & bit > 0) { result += 1; };
            if(bit == 0x1) { break; }
            bit /= 2;
        };
        result
    }
    fn sum_bytes(mut x: u256) -> u256 {
        let mut result: u256 = 0;
        loop {
            if (x == 0) { break; }
            result += (x & 0xff);
            x /= 0x100;
        };
        (result)
    }
}


//----------------------------------------
// Unit  tests
//
#[cfg(test)]
mod tests {
    
}
