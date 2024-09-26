// Game

const SEED_WEEK_SECONDS: u64 = 604800;
const SEED_OFFSET_SECONDS: u64 = 345600;

// Player

// Game

const DEFAULT_MAX_EXPIRY_HOURS: u64 = 72;

const DEFAULT_BOARD_SIZE: u8 = 8;

const DEFAULT_WHITE_POSITIONS: u64 = 0xFFFF;
const DEFAULT_BLACK_POSITIONS: u64 = 0xFFFF000000000000;

const DEFAULT_ROOK_POSITIONS: u64 = 0x8100000000000081;
const DEFAULT_KNIGHT_POSITIONS: u64 = 0x4200000000000042;
const DEFAULT_BISHOP_POSITIONS: u64 = 0x2400000000000024;
const DEFAULT_QUEEN_POSITIONS: u64 = 0x0800000000000008;
const DEFAULT_KING_POSITIONS: u64 = 0x1000000000000010;
const DEFAULT_PAWN_POSITIONS: u64 = 0x00FF00000000FF00;


// Constants for bitboard operations
const FILE_A: u64 = 0x0101010101010101;
const FILE_H: u64 = 0x8080808080808080;
const RANK_1: u64 = 0x00000000000000FF;
const RANK_8: u64 = 0xFF00000000000000;


const DIAGONAL_MASK: u64 = 0x8040201008040201;
const ANTI_DIAGONAL_MASK: u64 = 0x0102040810204080;


// let ROOK_MASKS: Array<u64> = array![
//             0x000101010101017E, 0x000202020202027C, 0x000404040404047A, 0x0008080808080876,
//             0x001010101010106E, 0x002020202020205E, 0x004040404040403E, 0x008080808080807E,
//             0x0001010101017E00, 0x0002020202027C00, 0x0004040404047A00, 0x0008080808087600,
//             0x0010101010106E00, 0x0020202020205E00, 0x0040404040403E00, 0x0080808080807E00,
//             0x00010101017E0100, 0x00020202027C0200, 0x00040404047A0400, 0x0008080808760800,
//             0x00101010106E1000, 0x00202020205E2000, 0x00404040403E4000, 0x00808080807E8000,
//             0x000101017E010100, 0x000202027C020200, 0x000404047A040400, 0x0008080876080800,
//             0x001010106E101000, 0x002020205E202000, 0x004040403E404000, 0x008080807E808000,
//             0x0001017E01010100, 0x0002027C02020200, 0x0004047A04040400, 0x0008087608080800,
//             0x0010106E10101000, 0x0020205E20202000, 0x0040403E40404000, 0x0080807E80808000,
//             0x00017E0101010100, 0x00027C0202020200, 0x00047A0404040400, 0x0008760808080800,
//             0x00106E1010101000, 0x00205E2020202000, 0x00403E4040404000, 0x00807E8080808000,
//             0x007E010101010100, 0x007C020202020200, 0x007A040404040400, 0x0076080808080800,
//             0x006E101010101000, 0x005E202020202000, 0x003E404040404000, 0x007E808080808000,
//             0x7E01010101010100, 0x7C02020202020200, 0x7A04040404040400, 0x7608080808080800,
//             0x6E10101010101000, 0x5E20202020202000, 0x3E40404040404000, 0x7E80808080808000
//         ];

//         let ROOK_MAGICS: Array<Magic> = array![
//             Magic { mask: 0x101010101017e, magic: 0x80002040400080, shift: 52, offset: 0 },
//             Magic { mask: 0x202020202027c, magic: 0x40001000200040, shift: 53, offset: 4096 },
//             Magic { mask: 0x404040404047a, magic: 0x80081000200080, shift: 53, offset: 8192 },
//             Magic { mask: 0x8080808080876, magic: 0x100010002000100, shift: 53, offset: 12288 },
//             Magic { mask: 0x1010101010106e, magic: 0x200020004000200, shift: 53, offset: 16384 },
//             Magic { mask: 0x2020202020205e, magic: 0x40004000800100, shift: 53, offset: 20480 },
//             Magic { mask: 0x4040404040403e, magic: 0x1000080004000200, shift: 53, offset: 24576 },
//             Magic { mask: 0x8080808080807e, magic: 0x800100020004000, shift: 52, offset: 28672 },
//             Magic { mask: 0x1010101017e00, magic: 0x80002040001000, shift: 53, offset: 32768 },
//             Magic { mask: 0x2020202027c00, magic: 0x100020080008000, shift: 54, offset: 36864 },
//             Magic { mask: 0x4040404047a00, magic: 0x100020001000200, shift: 54, offset: 40960 },
//             Magic { mask: 0x8080808087600, magic: 0x80010000800200, shift: 54, offset: 45056 },
//             Magic { mask: 0x10101010106e00, magic: 0x4000800080004100, shift: 54, offset: 49152 },
//             Magic { mask: 0x20202020205e00, magic: 0x200040008000820, shift: 54, offset: 53248 },
//             Magic { mask: 0x40404040403e00, magic: 0x200020004010108, shift: 54, offset: 57344 },
//             Magic { mask: 0x80808080807e00, magic: 0x400004000800100, shift: 53, offset: 61440 },
//             Magic { mask: 0x10101017e0100, magic: 0x200010004080, shift: 54, offset: 65536 },
//             Magic { mask: 0x20202027c0200, magic: 0x400080008020004, shift: 55, offset: 69632 },
//             Magic { mask: 0x40404047a0400, magic: 0x200080004008200, shift: 55, offset: 73728 },
//             Magic { mask: 0x8080808760800, magic: 0x200200200400080, shift: 55, offset: 77824 },
//             Magic { mask: 0x101010106e1000, magic: 0x8000800100020080, shift: 55, offset: 81920 },
//             Magic { mask: 0x202020205e2000, magic: 0x2000100008008080, shift: 55, offset: 86016 },
//             Magic { mask: 0x404040403e4000, magic: 0x100082000400100, shift: 55, offset: 90112 },
//             Magic { mask: 0x808080807e8000, magic: 0x180010002000100, shift: 54, offset: 94208 },
//             Magic { mask: 0x101017e010100, magic: 0x202040008000400, shift: 55, offset: 98304 },
//             Magic { mask: 0x202027c020200, magic: 0x20008080004000, shift: 56, offset: 102400 },
//             Magic { mask: 0x404047a040400, magic: 0x100020008020008, shift: 56, offset: 106496 },
//             Magic { mask: 0x8080876080800, magic: 0x2000100010004010, shift: 56, offset: 110592 },
//             Magic { mask: 0x1010106e101000, magic: 0x200040002008800, shift: 56, offset: 114688 },
//             Magic { mask: 0x2020205e202000, magic: 0x100020000820004, shift: 56, offset: 118784 },
//             Magic { mask: 0x4040403e404000, magic: 0x20008020010100, shift: 56, offset: 122880 },
//             Magic { mask: 0x8080807e808000, magic: 0x400004010008200, shift: 55, offset: 126976 },
//             Magic { mask: 0x1017e01010100, magic: 0x200200010004100, shift: 56, offset: 131072 },
//             Magic { mask: 0x2027c02020200, magic: 0x4040002020008, shift: 57, offset: 135168 },
//             Magic { mask: 0x4047a04040400, magic: 0x200100020008080, shift: 57, offset: 139264 },
//             Magic { mask: 0x8087608080800, magic: 0x8020004010100, shift: 57, offset: 143360 },
//             Magic { mask: 0x10106e10101000, magic: 0x100040080020004, shift: 57, offset: 147456 },
//             Magic { mask: 0x20205e20202000, magic: 0x80020004008080, shift: 57, offset: 151552 },
//             Magic { mask: 0x40403e40404000, magic: 0x8010004040010, shift: 57, offset: 155648 },
//             Magic { mask: 0x80807e80808000, magic: 0x200040008008080, shift: 56, offset: 159744 },
//             Magic { mask: 0x17e0101010100, magic: 0x400080002040100, shift: 57, offset: 163840 },
//             Magic { mask: 0x27c0202020200, magic: 0x2040008020400, shift: 58, offset: 167936 },
//             Magic { mask: 0x47a0404040400, magic: 0x100020080200080, shift: 58, offset: 172032 },
//             Magic { mask: 0x8760808080800, magic: 0x80004010004010, shift: 58, offset: 176128 },
//             Magic { mask: 0x106e1010101000, magic: 0x40080020008080, shift: 58, offset: 180224 },
//             Magic { mask: 0x205e2020202000, magic: 0x200200010084010, shift: 58, offset: 184320 },
//             Magic { mask: 0x403e4040404000, magic: 0x400004010200100, shift: 58, offset: 188416 },
//             Magic { mask: 0x807e8080808000, magic: 0x200100020004100, shift: 57, offset: 192512 },
//             Magic { mask: 0x7e010101010100, magic: 0x2080002041008, shift: 58, offset: 196608 },
//             Magic { mask: 0x7c020202020200, magic: 0x400080002080, shift: 59, offset: 200704 },
//             Magic { mask: 0x7a040404040400, magic: 0x80004000200080, shift: 59, offset: 204800 },
//             Magic { mask: 0x76080808080800, magic: 0x800100020004010, shift: 59, offset: 208896 },
//             Magic { mask: 0x6e101010101000, magic: 0x1000200040002080, shift: 59, offset: 212992 },
//             Magic { mask: 0x5e202020202000, magic: 0x4000200040100100, shift: 59, offset: 217088 },
//             Magic { mask: 0x3e404040404000, magic: 0x100100080020004, shift: 59, offset: 221184 },
//             Magic { mask: 0x7e808080808000, magic: 0x400080002040100, shift: 58, offset: 225280 },
//             Magic { mask: 0x7e01010101010100, magic: 0x2100400010080, shift: 59, offset: 229376 },
//             Magic { mask: 0x7c02020202020200, magic: 0x80044000100080, shift: 60, offset: 233472 },
//             Magic { mask: 0x7a04040404040400, magic: 0x80100400020080, shift: 60, offset: 237568 },
//             Magic { mask: 0x7608080808080800, magic: 0x80020004008080, shift: 60, offset: 241664 },
//             Magic { mask: 0x6e10101010101000, magic: 0x80010000804400, shift: 60, offset: 245760 },
//             Magic { mask: 0x5e20202020202000, magic: 0x1000200040002100, shift: 60, offset: 249856 },
//             Magic { mask: 0x3e40404040404000, magic: 0x800100020005000, shift: 60, offset: 253952 },
//             Magic { mask: 0x7e80808080808000, magic: 0x100080200040200, shift: 59, offset: 258048 }
//         ];