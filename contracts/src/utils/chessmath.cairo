
use rl_chess::helpers::math::{Math, MathTrait};

const SCALE_FACTOR: u256 = 10000; // Equivalent to 10_000 in Solidity


fn calculate_elo(white_elo: u16, black_elo: u16, result: u16, k: u16) -> (u16, u16) {
    let white_elo_f: u256 = white_elo.into();
    let black_elo_f: u256 = black_elo.into();
    let k_f: u256 = k.into();

    // Convert result to score (100 for win, 50 for draw, 0 for loss)
    let score = match result {
        0 => panic_with_felt252('result must be >0'),
        1 => 100, // White wins
        2 => 0,   // Black wins
        3 => 50,  // Draw
        _ => panic_with_felt252('Invalid result')
    };

    // Calculate rating change for white
    let (change_white, negative_white) = rating_change(white_elo_f, black_elo_f, score, k_f);

    // Calculate rating change for black (invert the score)
    let (change_black, negative_black) = rating_change(black_elo_f, white_elo_f, 100 - score, k_f);

    // Apply changes
    let new_white_elo = if negative_white {
        white_elo_f - (change_white)
    } else {
        white_elo_f + (change_white)
    };

    let new_black_elo = if negative_black {
        black_elo_f - (change_black)
    } else {
        black_elo_f + (change_black)
    };

    (new_white_elo.try_into().unwrap(), new_black_elo.try_into().unwrap())
}


fn rating_change(rating_a: u256, rating_b: u256, score: u256, k_factor: u256) -> (u256, bool) {
    let k_factor_scaled = k_factor * SCALE_FACTOR;
    let negative = rating_b < rating_a;
    let rating_diff = if negative {
        rating_a - rating_b
    } else {
        rating_b - rating_a
    };

    // Check for overflow/underflow conditions
    // checks against overflow/underflow, discovered via fuzzing
    // large rating diffs leads to 10^ratingDiff being too large to fit in a uint256
    assert(rating_diff < 1126, 'Rating difference too large');
    // large rating diffs when applying the scale factor leads to underflow (800 - ratingDiff)
    if negative {
        assert(rating_diff < 800, 'Rating difference too large');
    }

    let n = if negative {
        800 - rating_diff
    } else {
        800 + rating_diff
    };

    // Approximate pow(10, n / 25) using repeated multiplication
    let mut powered = 10_u256; // the value of 10 ^ numerator
    let mut i = 0;
    loop {
        if i == n / 25 {
            break;
        }
        powered = powered * 10;
        i += 1;
    };

    let powered = MathTrait::sixteenth_rootU256(powered);// the value of 16th root of 10 ^ numerator (fully resolved 10 ^ (ratingDiff / 400))

    // Calculate expected score and actual score
    // given `change = kFactor * (score - expectedScore)` we can distribute kFactor to both terms
    let k_expected_score = k_factor_scaled / (100 + powered); // both numerator and denominator scaled up by 100
    let k_score = k_factor * score; //input score is already scaled up by 100

    // determines the sign of the ELO change
    let negative = k_score < k_expected_score;
    let change = if negative {
        k_expected_score - k_score
    } else {
        k_score - k_expected_score
    };

    (change, negative)
}