// Core imports

use core::debug::PrintTrait;

// Internal imports

use rl_chess::constants::DEFAULT_BOARD_SIZE;

// Errors

mod errors {
    const MAPPER_INVALID_POSITION: felt252 = 'Mapper: invalid position';
}

#[generate_trait]
impl Mapper of MapperTrait {
    #[inline]
    fn decompose(position: u8) -> (u8, u8) {
        let index = position - 1;
        let row = index / DEFAULT_BOARD_SIZE;
        let col = index % DEFAULT_BOARD_SIZE;
        (row, col)
    }

    #[inline]
    fn compose(row: u8, col: u8) -> u8 {
        let index = row * DEFAULT_BOARD_SIZE + col;
        index + 1
    }
}

#[generate_trait]
impl MapperAssert of AssertTrait {
    #[inline]
    fn assert_valid_position(position: u8) {
        assert(
            position > 0 && position <= DEFAULT_BOARD_SIZE * DEFAULT_BOARD_SIZE,
            errors::MAPPER_INVALID_POSITION
        );
    }
}
