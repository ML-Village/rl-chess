// Errors

mod errors {
    const COLOR_INVALID_VALUE: felt252 = 'Color: invalid value';
}

#[derive(Copy, Drop, Serde, Introspect)]
enum Color {
    None,
    White,
    Black,
}

#[generate_trait]
impl ColorImpl of ColorTrait {

    // (origin: starter-chess) this for using 32 index pieces 
    #[inline]
    fn from(index: u8) -> Color {
        if index < 16 {
            return Color::White;
        } else if index < 32 {
            return Color::Black;
        } else {
            return Color::None;
        }
    }

    // (origin: starter-chess)
    #[inline]
    fn next(self: Color) -> Color {
        match self {
            Color::None => Color::None,
            Color::White => Color::Black,
            Color::Black => Color::White,
        }
    }

    #[inline]
    fn opposite(self: Color) -> Color {
        match self {
            Color::None => Color::None,
            Color::White => Color::Black,
            Color::Black => Color::White,
        }
    }

    #[inline]
    fn to_string(self: Color) -> ByteArray {
        match self {
            Color::None => "None",
            Color::White => "White",
            Color::Black => "Black",
        }
    }

    #[inline]
    fn to_string_char(self: Color) -> ByteArray {
        match self {
            Color::None => "N",
            Color::White => "W",
            Color::Black => "B",
        }
    }
}

#[generate_trait]
impl ColorAssert of AssertTrait {
    #[inline]
    fn assert_is_valid(self: Color) {
        assert(self != Color::None.into(), errors::COLOR_INVALID_VALUE);
    }
}

impl IntoColorFelt252 of core::Into<Color, felt252> {
    #[inline]
    fn into(self: Color) -> felt252 {
        match self {
            Color::None => 'NONE',
            Color::White => 'WHITE',
            Color::Black => 'BLACK',
        }
    }
}

impl IntoColorU8 of core::Into<Color, u8> {
    #[inline]
    fn into(self: Color) -> u8 {
        match self {
            Color::None => 0,
            Color::White => 1,
            Color::Black => 2,
        }
    }
}

impl IntoU8Color of core::Into<u8, Color> {
    #[inline]
    fn into(self: u8) -> Color {
        let card: felt252 = self.into();
        match card {
            0 => Color::None,
            1 => Color::White,
            2 => Color::Black,
            _ => Color::None,
        }
    }
}

impl PartialEqColor of core::PartialEq<Color> {
    #[inline]
    fn eq(lhs: @Color, rhs: @Color) -> bool {
        let left: u8 = (*lhs).into();
        let right: u8 = (*rhs).into();
        left == right
    }
}

impl ColorPrint of core::debug::PrintTrait<Color> {
    #[inline]
    fn print(self: Color) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
