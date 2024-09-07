// use debug::PrintTrait;

trait MathTrait<T, I> {
    // returns minimum value
    fn min(a: T, b: T) -> T;
    // returns maximum value
    fn max(a: T, b: T) -> T;
    // // returns a value clamped between min and max
    // fn clamp(v: T, min: T, max: T) -> T;
    // // safe subtraction
    // fn sub(a: T, b: T) -> T;
    // // returns GDC of two numbers
    // fn gdc(a: T, b: T) -> T;
    // // map a value form one range to another
    // fn map(v: T, in_min: T, in_max: T, out_min: T, out_max: T) -> T;
    // // power
    // fn pow(base: T, exp: T) -> T;
    // // quared distance in 2D space
    // fn squaredDistance(x1: T, y1: T, x2: T, y2: T) -> T;

    // absolute value
    fn abs(v: I) -> T;

    // signum
    fn signum(v: T) -> I;
}

impl MathU8 of MathTrait<u8, i8> {
    fn min(a: u8, b: u8) -> u8 {
        if (a < b) { (a) } else { (b) }
    }
    fn max(a: u8, b: u8) -> u8 {
        if (a > b) { (a) } else { (b) }
    }
    fn abs(v: i8) -> u8 {
        (if (v < 0) { (-v) } else { (v) }).try_into().unwrap()
    }
    fn signum(v: u8) -> i8 {
        (if (v == 0) { (0) } else if (v > 0) { (1) } else { (-1) }
            ).try_into().unwrap()
    }
}

// impl MathU16 of MathTrait<u16> {
//     fn min(a: u16, b: u16) -> u16 {
//         if (a < b) { (a) } else { (b) }
//     }
//     fn max(a: u16, b: u16) -> u16 {
//         if (a > b) { (a) } else { (b) }
//     }
//     fn clamp(v: u16, min: u16, max: u16) -> u16 {
//         if (v < min) { (min) } else if (v > max) { (max) } else { (v) }
//     }

//     fn sub(a: u16, b: u16) -> u16 {
//         if (b >= a) { (0) } else { (a - b) }
//     }

//     fn gdc(a: u16, b: u16) -> u16 {
//         // recursive (not fastest)
//         if (b == 0) { (a) } else { (MathU16::gdc(b, a % b)) }
//     }

//     fn map(v: u16, in_min: u16, in_max: u16, out_min: u16, out_max: u16) -> u16 {
//         if (out_min > out_max) { 
//             (out_min - MathU16::map(v, in_min, in_max, 0, out_min - out_max))
//         } else {
//             (out_min + (((out_max - out_min) / (in_max - in_min)) * (v - in_min)))
//         }
//     }

//     fn pow(base: u16, exp: u16) -> u16 {
//         if exp == 0 { 1 }
//         else if exp == 1 { base }
//         else if exp % 2 == 0 { MathU16::pow(base * base, exp / 2) }
//         else { base * MathU16::pow(base * base, (exp - 1) / 2) }
//     }

//     fn squaredDistance(x1: u16, y1: u16, x2: u16, y2: u16) -> u16 {
//         let dx = if (x1 > x2) { (x1 - x2) } else { (x2 - x1) };
//         let dy = if (y1 > y2) { (y1 - y2) } else { (y2 - y1) };
//         (dx * dx + dy * dy)
//     }

//     fn abs(v: i16) -> u16 {
//         if (v < 0) { (-v) } else { (v) }
//     }

//     fn signum(v: u16) -> i8 {
//         if (v == 0) { (0) } else if (v > 0) { (1) } else { (-1) }
//     }
// }

// impl MathU32 of MathTrait<u32> {
//     fn min(a: u32, b: u32) -> u32 {
//         if (a < b) { (a) } else { (b) }
//     }
//     fn max(a: u32, b: u32) -> u32 {
//         if (a > b) { (a) } else { (b) }
//     }
//     fn clamp(v: u32, min: u32, max: u32) -> u32 {
//         if (v < min) { (min) } else if (v > max) { (max) } else { (v) }
//     }

//     fn sub(a: u32, b: u32) -> u32 {
//         if (b >= a) { (0) } else { (a - b) }
//     }

//     fn gdc(a: u32, b: u32) -> u32 {
//         if (b == 0) { (a) } else { (MathU32::gdc(b, a % b)) }
//     }

//     fn map(v: u32, in_min: u32, in_max: u32, out_min: u32, out_max: u32) -> u32 {
//         if (out_min > out_max) { 
//             (out_min - MathU32::map(v, in_min, in_max, 0, out_min - out_max))
//         } else {
//             (out_min + (((out_max - out_min) / (in_max - in_min)) * (v - in_min)))
//         }
//     }

//     fn pow(base: u32, exp: u32) -> u32 {
//         if exp == 0 { 1 }
//         else if exp == 1 { base }
//         else if exp % 2 == 0 { MathU32::pow(base * base, exp / 2) }
//         else { base * MathU32::pow(base * base, (exp - 1) / 2) }
//     }

//     fn squaredDistance(x1: u32, y1: u32, x2: u32, y2: u32) -> u32 {
//         let dx = if (x1 > x2) { (x1 - x2) } else { (x2 - x1) };
//         let dy = if (y1 > y2) { (y1 - y2) } else { (y2 - y1) };
//         (dx * dx + dy * dy)
//     }

//     fn abs(v: i32) -> u32 {
//         if (v < 0) { (-v) } else { (v) }
//     }

//     fn signum(v: u32) -> i8 {
//         if (v == 0) { (0) } else if (v > 0) { (1) } else { (-1) }
//     }
// }

// impl MathU64 of MathTrait<u64> {
//     fn min(a: u64, b: u64) -> u64 {
//         if (a < b) { (a) } else { (b) }
//     }
//     fn max(a: u64, b: u64) -> u64 {
//         if (a > b) { (a) } else { (b) }
//     }
//     fn clamp(v: u64, min: u64, max: u64) -> u64 {
//         if (v < min) { (min) } else if (v > max) { (max) } else { (v) }
//     }

//     fn sub(a: u64, b: u64) -> u64 {
//         if (b >= a) { (0) } else { (a - b) }
//     }

//     fn gdc(a: u64, b: u64) -> u64 {
//         if (b == 0) { (a) } else { (MathU64::gdc(b, a % b)) }
//     }

//     fn map(v: u64, in_min: u64, in_max: u64, out_min: u64, out_max: u64) -> u64 {
//         if (out_min > out_max) { 
//             (out_min - MathU64::map(v, in_min, in_max, 0, out_min - out_max))
//         } else {
//             (out_min + (((out_max - out_min) / (in_max - in_min)) * (v - in_min)))
//         }
//     }

//     fn pow(base: u64, exp: u64) -> u64 {
//         if exp == 0 { 1 }
//         else if exp == 1 { base }
//         else if exp % 2 == 0 { MathU64::pow(base * base, exp / 2) }
//         else { base * MathU64::pow(base * base, (exp - 1) / 2) }
//     }

//     fn squaredDistance(x1: u64, y1: u64, x2: u64, y2: u64) -> u64 {
//         let dx = if (x1 > x2) { (x1 - x2) } else { (x2 - x1) };
//         let dy = if (y1 > y2) { (y1 - y2) } else { (y2 - y1) };
//         (dx * dx + dy * dy)
//     }

//     fn abs(v: i64) -> u64 {
//         if (v < 0) { (-v) } else { (v) }
//     }

//     fn signum(v: u64) -> i8 {
//         if (v == 0) { (0) } else if (v > 0) { (1) } else { (-1) }
//     }
// }

// impl MathU128 of MathTrait<u128> {
//     fn min(a: u128, b: u128) -> u128 {
//         if (a < b) { (a) } else { (b) }
//     }
//     fn max(a: u128, b: u128) -> u128 {
//         if (a > b) { (a) } else { (b) }
//     }
//     fn clamp(v: u128, min: u128, max: u128) -> u128 {
//         if (v < min) { (min) } else if (v > max) { (max) } else { (v) }
//     }

//     fn sub(a: u128, b: u128) -> u128 {
//         if (b >= a) { (0) } else { (a - b) }
//     }

//     fn gdc(a: u128, b: u128) -> u128 {
//         if (b == 0) { (a) } else { (MathU128::gdc(b, a % b)) }
//     }

//     fn map(v: u128, in_min: u128, in_max: u128, out_min: u128, out_max: u128) -> u128 {
//         if (out_min > out_max) { 
//             (out_min - MathU128::map(v, in_min, in_max, 0, out_min - out_max))
//         } else {
//             (out_min + (((out_max - out_min) / (in_max - in_min)) * (v - in_min)))
//         }
//     }

//     /// Raise a number to a power.
//     /// O(log n) time complexity.
//     /// * `base` - The number to raise.
//     /// * `exp` - The exponent.
//     /// # Returns
//     /// * `u128` - The result of base raised to the power of exp.
//     fn pow(base: u128, exp: u128) -> u128 {
//         if exp == 0 { 1 }
//         else if exp == 1 { base }
//         else if exp % 2 == 0 { MathU128::pow(base * base, exp / 2) }
//         else { base * MathU128::pow(base * base, (exp - 1) / 2) }
//     }

//     fn squaredDistance(x1: u128, y1: u128, x2: u128, y2: u128) -> u128 {
//         let dx = if (x1 > x2) { (x1 - x2) } else { (x2 - x1) };
//         let dy = if (y1 > y2) { (y1 - y2) } else { (y2 - y1) };
//         (dx * dx + dy * dy)
//     }

//     fn abs(v: i128) -> u128 {
//         if (v < 0) { (-v) } else { (v) }
//     }

//     fn signum(v: u128) -> i8 {
//         if (v == 0) { (0) } else if (v > 0) { (1) } else { (-1) }
//     }
// }

// impl MathU256 of MathTrait<u256> {
//     fn min(a: u256, b: u256) -> u256 {
//         if (a < b) { (a) } else { (b) }
//     }
//     fn max(a: u256, b: u256) -> u256 {
//         if (a > b) { (a) } else { (b) }
//     }
//     fn clamp(v: u256, min: u256, max: u256) -> u256 {
//         if (v < min) { (min) } else if (v > max) { (max) } else { (v) }
//     }

//     fn sub(a: u256, b: u256) -> u256 {
//         if (b >= a) { (0) } else { (a - b) }
//     }

//     fn gdc(a: u256, b: u256) -> u256 {
//         if (b == 0) { (a) } else { (MathU256::gdc(b, a % b)) }
//     }

//     fn map(v: u256, in_min: u256, in_max: u256, out_min: u256, out_max: u256) -> u256 {
//         if (out_min > out_max) { 
//             (out_min - MathU256::map(v, in_min, in_max, 0, out_min - out_max))
//         } else {
//             (out_min + (((out_max - out_min) / (in_max - in_min)) * (v - in_min)))
//         }
//     }

//     fn pow(base: u256, exp: u256) -> u256 {
//         if exp == 0 { 1 }
//         else if exp == 1 { base }
//         else if exp % 2 == 0 { MathU256::pow(base * base, exp / 2) }
//         else { base * MathU256::pow(base * base, (exp - 1) / 2) }
//     }

//     fn squaredDistance(x1: u256, y1: u256, x2: u256, y2: u256) -> u256 {
//         let dx = if (x1 > x2) { (x1 - x2) } else { (x2 - x1) };
//         let dy = if (y1 > y2) { (y1 - y2) } else { (y2 - y1) };
//         (dx * dx + dy * dy)
//     }

//     // fn abs(v: i256) -> u256 {
//     //     if (v < 0) { (-v) } else { (v) }
//     // }

//     fn signum(v: u256) -> i8 {
//         if (v == 0) { (0) } else if (v > 0) { (1) } else { (-1) }
//     }
// }


//----------------------------------------
// Unit  tests
//
#[cfg(test)]
mod tests {
    
}
