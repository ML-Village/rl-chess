use starknet::ContractAddress;

#[dojo::interface]
trait IAdmin {
    fn set_game_format(
        self: @TContractState,
        format_id: u16,
        description: felt252,
        turn_expiry: u64,
        total_time_per_side: u64,
        total_time_string: felt252,
        increment: u8,
    );

    fn remove_game_format(
        self: @TContractState,
        format_id: u16,
    );
}

#[dojo::contract]
mod admin {
    use debug::PrintTrait;
    use traits::{Into, TryInto};
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};

    use rl_chess::models::index::Format;

    mod Errors {

    }


    fn dojo_init(
        ref world: IWorldDispatcher,
    ) {    
        // initialize game formats
        set!(world, (
                Format { 
                    format_id: 1, 
                    description: 'Daily-1',
                    turn_expiry: 0,
                    total_time_per_side: 60*60*24, // 1 day
                    total_time_string: '1-day',
                    increment: 0
                },

                Format {
                    format_id: 2,
                    description: 'Daily-2',
                    turn_expiry: 0,
                    total_time_per_side: 60*60*24*2, // 2 days
                    total_time_string: '2-days',
                    increment: 0
                },
                Format {
                    format_id: 3,
                    description: 'Daily-3',
                    turn_expiry: 0,
                    total_time_per_side: 60*60*24*3, // 3 days
                    total_time_string: '3-days',
                    increment: 0
                },
                Format {
                    format_id: 4,
                    description: 'Daily-5',
                    turn_expiry: 0,
                    total_time_per_side: 60*60*24*5, // 7 days
                    total_time_string: '5-days',
                    increment: 0
                },
                Format {
                    format_id: 5,
                    description: 'Daily-7',
                    turn_expiry: 0,
                    total_time_per_side: 60*60*24*7, // 7 days
                    total_time_string: '7-days',
                    increment: 0
                },
                Format {
                    format_id: 6,
                    description: 'Daily-14',
                    turn_expiry: 0,
                    total_time_per_side: 60*60*24*14, // 14 days
                    total_time_string: '14-days',
                    increment: 0
                },

                // Rapids
                Format {
                    format_id: 7,
                    description: 'Rapid-10',
                    turn_expiry: 0,
                    total_time_per_side: 60*10, // 15 minutes
                    total_time_string: '10-mins',
                    increment: 0
                },

                Format {
                    format_id: 8,
                    description: 'Rapid-10-5',
                    turn_expiry: 0,
                    total_time_per_side: 60*10, // 15 minutes
                    total_time_string: '10 mins | 5s',
                    increment: 5
                },

                Format {
                    format_id: 9,
                    description: 'Rapid-15',
                    turn_expiry: 0,
                    total_time_per_side: 60*15, // 15 minutes
                    total_time_string: '15-mins',
                    increment: 0
                },

                Format {
                    format_id: 10,
                    description: 'Rapid-20',
                    turn_expiry: 0,
                    total_time_per_side: 60*20, // 15 minutes
                    total_time_string: '20  mins',
                    increment: 0
                },

                Format {
                    format_id: 11,
                    description: 'Rapid-30',
                    turn_expiry: 0,
                    total_time_per_side: 60*30, // 15 minutes
                    total_time_string: '30 mins',
                    increment: 0
                },

                Format {
                    format_id: 12,
                    description: 'Rapid-60',
                    turn_expiry: 0,
                    total_time_per_side: 60*60, // 60 minutes
                    total_time_string: '60 mins',
                    increment: 0
                },

                Format {
                    format_id: 13,
                    description: 'Blitz-3',
                    turn_expiry: 0,
                    total_time_per_side: 60*3, // 3 mins
                    total_time_string: '3 mins',
                    increment: 0
                },

                Format {
                    format_id: 14,
                    description: 'Blitz-3-2',
                    turn_expiry: 0,
                    total_time_per_side: 60*3, // 3 mins
                    total_time_string: '3 mins | 2s',
                    increment: 2
                },

                Format {
                    format_id: 15,
                    description: 'Blitz-5',
                    turn_expiry: 0,
                    total_time_per_side: 60*5, // 5 mins
                    total_time_string: '5 mins',
                    increment: 0
                },

                Format {
                    format_id: 16,
                    description: 'Blitz-5-2',
                    turn_expiry: 0,
                    total_time_per_side: 60*5, // 5 mins
                    total_time_string: '5 mins | 2s',
                    increment: 2
                },

                Format {
                    format_id: 17,
                    description: 'Blitz-5-5',
                    turn_expiry: 0,
                    total_time_per_side: 60*5, // 5 mins
                    total_time_string: '5 mins | 5s',
                    increment: 0
                },

                // Bullet
                Format {
                    format_id: 18,
                    description: 'Bullet-1',
                    turn_expiry: 0,
                    total_time_per_side: 60*1, // 1 min
                    total_time_string: '1 min',
                    increment: 0
                },

                Format {
                    format_id: 19,
                    description: 'Bullet-1-1',
                    turn_expiry: 0,
                    total_time_per_side: 60*1, // 1 min
                    total_time_string: '1 min | 1s',
                    increment: 1
                },

                Format {
                    format_id: 20,
                    description: 'Bullet-2-1',
                    turn_expiry: 0,
                    total_time_per_side: 60*2, // 2 min
                    total_time_string: '2 min | 1s',
                    increment: 1
                },

            )
        );
    }

    // impl: implement functions specified in trait
    #[abi(embed_v0)]
    impl AdminImpl of super::IAdmin<ContractState> {
        fn set_game_format(ref world: IWorldDispatcher, 
            format_id: u16, 
            description: felt252, 
            turn_expiry: u64, 
            total_time_per_side: u64, 
            total_time_string: felt252, 
            increment: u8) {
                let format = Format {
                    format_id,
                    description,
                    turn_expiry,
                    total_time_per_side,
                    total_time_string,
                    increment
                };

                set!(world, (format));
        }
        
        fn remove_game_format(ref world: IWorldDispatcher, format_id: u16) {
            let format = get!(world, format_id, (Format));
            delete!(world, (format));
        }
    }


}
