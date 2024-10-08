// Core imports

use core::debug::PrintTrait;

// Internal imports

use rl_chess::helpers::math::Math;
use rl_chess::helpers::mapper::Mapper;
use rl_chess::constants::DEFAULT_BOARD_SIZE;

#[generate_trait]
impl Masker of MaskerTrait {
    #[inline]
    fn compute_mask(from: u8, to: u8) -> u64 {
        let (from_row, from_col) = Mapper::decompose(from);
        let (to_row, to_col) = Mapper::decompose(to);
        let delta_row = Math::sub_abs(from_row, to_row);
        let delta_col = Math::sub_abs(from_col, to_col);
        // [Compute] Mask
        if (from_row == to_row) {
            // [Compute] Path into a row
            return Self::compute_row_mask(from, to);
        } else if (from_col == to_col) {
            // [Compute] Path into a column
            return Self::compute_col_mask(from, to);
        } else if (delta_row == delta_col) {
            // [Compute] Diagonal path
            let exp: u8 = if (from_col < to_col && from_row < to_row)
                || (from_col > to_col && from_row > to_row) {
                DEFAULT_BOARD_SIZE + 1
            } else {
                DEFAULT_BOARD_SIZE - 1
            };
            let offset = Math::pow(2, exp.into());
            return Self::compute_diag_mask(from, to, exp, offset);
        }
        0
    }

    #[inline]
    fn compute_row_mask(from: u8, to: u8) -> u64 {
        if from < to {
            // [Compute] Path into a row from left to right
            let mask: u64 = Math::pow(2, (to - from).into()) - 2;
            let offset: u64 = Math::pow(2, (from - 1).into());
            return mask * offset;
        }
        // [Compute] Path into a row from right to left
        let mask: u64 = Math::pow(2, (from - to).into()) - 2;
        let offset: u64 = Math::pow(2, (to - 1).into());
        mask * offset
    }

    #[inline]
    fn compute_col_mask(from: u8, to: u8) -> u64 {
        let offset: u64 = Math::pow(2, DEFAULT_BOARD_SIZE.into());
        let mut mask: u64 = 0;
        if from < to {
            // [Compute] Path into a column from bottom to top
            let mut index = from + DEFAULT_BOARD_SIZE;
            loop {
                if index >= to {
                    break mask;
                }
                mask = mask * offset + offset;
                index += DEFAULT_BOARD_SIZE;
            };
            let shift: u64 = Math::pow(2, (from - 1).into());
            return mask * shift;
        }
        // [Compute] Path into a column from bottom to top
        let mut index = to + DEFAULT_BOARD_SIZE;
        loop {
            if index >= from {
                break mask;
            }
            mask = mask * offset + offset;
            index += DEFAULT_BOARD_SIZE;
        };
        let shift: u64 = Math::pow(2, (to - 1).into());
        mask * shift
    }

    #[inline]
    fn compute_diag_mask(from: u8, to: u8, exp: u8, offset: u64) -> u64 {
        let mut mask: u64 = 0;
        if from < to {
            // [Compute] Path into a diagonal from bottom to top
            let mut index = from + exp;
            loop {
                if index >= to {
                    break mask;
                }
                mask = mask * offset + offset;
                index += exp;
            };
            let shift: u64 = Math::pow(2, (from - 1).into());
            return mask * shift;
        }
        // [Compute] Path into a diagonal from top to bottom
        let mut index = to + exp;
        loop {
            if index >= from {
                break mask;
            }
            mask = mask * offset + offset;
            index += exp;
        };
        let shift: u64 = Math::pow(2, (to - 1).into());
        mask * shift
    }
}
