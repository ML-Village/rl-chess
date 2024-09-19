import { FaRegSun } from "react-icons/fa";
import { TfiAlarmClock } from "react-icons/tfi";
import { FaBoltLightning } from "react-icons/fa6";
import { GiBulletBill } from "react-icons/gi";
import { IconType } from 'react-icons';

interface GameFormatConfig {
    [key: number]: {
        format_id: number;
        description: string;
        turn_expiry: number;
        total_time_per_side: number;
        total_time_string: string;
        increment: number;
        available: boolean;
        icon: IconType;
    };
}

export const gameFormatconfig: GameFormatConfig  = {
    // Daily-1
    1: {
            format_id: 1,
            description: "Daily-1",
            turn_expiry: 0,
            total_time_per_side: 60*60*24, // 1 day
            total_time_string: "1 day",
            increment: 0,
            available: true,
            icon: FaRegSun,
        },
    // Daily-2
    2: {
            format_id: 2,
            description: "Daily-2",
            turn_expiry: 0,
            total_time_per_side: 60*60*24*2, // 2 days
            total_time_string: "2 days",
            increment: 0,
            available: true,
            icon: FaRegSun,
        },
    // Daily-3
    3: {
        format_id: 3,
        description: "Daily-3",
        turn_expiry: 0,
        total_time_per_side: 60*60*24*3, // 3 days
        total_time_string: "3 days",
        increment: 0,
        available: true,
        icon: FaRegSun,
    },
    // Daily-5
    4: {
        format_id: 4,
        description: "Daily-5",
        turn_expiry: 0,
        total_time_per_side: 60*60*24*5, // 5 days
        total_time_string: "5 days",
        increment: 0,
        available: true,
        icon: FaRegSun,
    },
    // Daily-7
    5: {
        format_id: 5,
        description: "Daily-7",
        turn_expiry: 0,
        total_time_per_side: 60*60*24*7, // 7 days
        total_time_string: "7 days",
        increment: 0,
        available: true,
        icon: FaRegSun,
    },
    // Daily-14
    6: {
        format_id: 6,
        description: "Daily-14",
        turn_expiry: 0,
        total_time_per_side: 60*60*24*14, // 14 days
        total_time_string: "14 days",
        increment: 0,
        available: true,
        icon: FaRegSun,
    },
    

    // Rapid 10
    7: {
        format_id: 7,
        description: "Rapid-10",
        turn_expiry: 0,
        total_time_per_side: 60*10, // 10 mins
        total_time_string: "10 mins",
        increment: 0,
        available: true,
        icon: TfiAlarmClock,
    },
    // Rapid 10-5
    8: {
        format_id: 8,
        description: "Rapid-10-5",
        turn_expiry: 0,
        total_time_per_side: 60*10, // 10 mins
        total_time_string: "10mins | 5s",
        increment: 5,
        available: true,
        icon: TfiAlarmClock,
    },
    // Rapid 15
    9: {
        format_id: 9,
        description: "Rapid-15",
        turn_expiry: 0,
        total_time_per_side: 60*15, // 15 mins
        total_time_string: "15 mins",
        increment: 0,
        available: true,
        icon: TfiAlarmClock,
    },
    // Rapid 20
    10: {
        format_id: 10,
        description: "Rapid-20",
        turn_expiry: 0,
        total_time_per_side: 60*20, // 20 mins
        total_time_string: "20 mins",
        increment: 0,
        available: true,
        icon: TfiAlarmClock,
    },
    // Rapid 30
    11: {
        format_id: 11,
        description: "Rapid-30",
        turn_expiry: 0,
        total_time_per_side: 60*30, // 30 mins
        total_time_string: "30 mins",
        increment: 0,
        available: true,
        icon: TfiAlarmClock,
    },
    // Rapid 60
    12: {
        format_id: 12,
        description: "Rapid-60",
        turn_expiry: 0,
        total_time_per_side: 60*60, // 60 mins
        total_time_string: "60 mins",
        increment: 0,
        available: true,
        icon: TfiAlarmClock,
    },


    // Blitz 3
    13: {
        format_id: 13,
        description: "Blitz-3",
        turn_expiry: 0,
        total_time_per_side: 60*3, // 3 min
            total_time_string: "3 mins",
            increment: 0,
            available: true,
            icon: FaBoltLightning,
        },
    
    // Blitz 3-2
    14: {
        format_id: 14,
        description: "Blitz-3-2",
        turn_expiry: 0,
        total_time_per_side: 60*3, // 3 min
        total_time_string: "3 mins | 2s",
        increment: 2,
        available: true,
        icon: FaBoltLightning,
    },

    // Blitz 5
    15: {
        format_id: 15,
        description: "Blitz-5",
        turn_expiry: 0,
        total_time_per_side: 60*5, // 5 min
        total_time_string: "5 mins",
        increment: 0,
        available: true,
        icon: FaBoltLightning,
    },

    // Blitz 5-2
    16: {
        format_id: 16,
        description: "Blitz-5-2",
        turn_expiry: 0,
        total_time_per_side: 60*5, // 5 min
        total_time_string: "5 mins | 2s",
        increment: 2,
        available: true,
        icon: FaBoltLightning,
    },

    // Blitz 5-5
    17: {
        format_id: 17,
        description: "Blitz-5-5",
        turn_expiry: 0,
        total_time_per_side: 60*5, // 5 min
        total_time_string: "5 mins | 5s",
        increment: 5,
        available: true,
        icon: FaBoltLightning,
    },

    // Bullet 1
    18: {
        format_id: 18,
        description: "Bullet-1",
        turn_expiry: 0,
        total_time_per_side: 60*1, // 1 min
        total_time_string: "1 min",
        increment: 0,
        available: true,
        icon: GiBulletBill,
    },

    // Bullet 1-1
    19: {
        format_id: 19,
        description: "Bullet-1-1",
        turn_expiry: 0,
        total_time_per_side: 60*1, // 1 min
        total_time_string: "1 min | 1s",
        increment: 1,
        available: true,
        icon: GiBulletBill,
    },

    // Bullet 2-1
    20: {
        format_id: 20,
        description: "Bullet-2-1",
        turn_expiry: 0,
        total_time_per_side: 60*2, // 2 min
        total_time_string: "2 mins | 1s",
        increment: 1,
        available: true,
        icon: GiBulletBill,
    },

}

export const gameCategoryOrder = [
    "Bullet",
    "Blitz",
    "Rapid",
    "Daily",
]
    