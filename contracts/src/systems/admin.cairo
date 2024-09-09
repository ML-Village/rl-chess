use starknet::ContractAddress;

// Dojo imports
use dojo::world::IWorldDispatcher;

#[starknet::interface]
trait IAdmin<TContractState> {
    fn add_game_format(
        self: @TContractState,
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
    // Component imports

    use rl_chess::components::playable::PlayableComponent;

    // Starknet imports
    use debug::PrintTrait;
    use traits::{Into, TryInto};
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};

    // Local imports

    use super::IAdmin;
    use rl_chess::models::index::Format;


    // Components

    component!(path: PlayableComponent, storage: playable, event: PlayableEvent);
    impl PlayableInternalImpl = PlayableComponent::InternalImpl<ContractState>;

    // Storage

    #[storage]
    struct Storage {
        #[substorage(v0)]
        playable: PlayableComponent::Storage,
    }


    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        PlayableEvent: PlayableComponent::Event,
    }



    fn dojo_init(
        self: @ContractState,
    ) {    
        // initialize game formats

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Daily-1',
            turn_expiry: 0,
            total_time_per_side: 60*60*24, // 1 day
            total_time_string: '1-day',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Daily-2',
            turn_expiry: 0,
            total_time_per_side: 60*60*24*2, // 2 days
            total_time_string: '2-days',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Daily-3',
            turn_expiry: 0,
            total_time_per_side: 60*60*24*3, // 3 days
            total_time_string: '3-days',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Daily-5',
            turn_expiry: 0,
            total_time_per_side: 60*60*24*5, // 7 days
            total_time_string: '5-days',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Daily-7',
            turn_expiry: 0,
            total_time_per_side: 60*60*24*7, // 7 days
            total_time_string: '7-days',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Daily-14',
            turn_expiry: 0,
            total_time_per_side: 60*60*24*14, // 14 days
            total_time_string: '14-days',
            increment: 0
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Rapid-10',
            turn_expiry: 0,
            total_time_per_side: 60*10, // 15 minutes
            total_time_string: '10-mins',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Rapid-10-5',
            turn_expiry: 0,
            total_time_per_side: 60*10, // 15 minutes
            total_time_string: '10 mins | 5s',
            increment: 5
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Rapid-15',
            turn_expiry: 0,
            total_time_per_side: 60*15, // 15 minutes
            total_time_string: '15-mins',
            increment: 0
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Rapid-20',
            turn_expiry: 0,
            total_time_per_side: 60*20, // 15 minutes
            total_time_string: '20  mins',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Rapid-30',
            turn_expiry: 0,
            total_time_per_side: 60*30, // 15 minutes
            total_time_string: '30 mins',
            increment: 0
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Rapid-60',
            turn_expiry: 0,
            total_time_per_side: 60*60, // 60 minutes
            total_time_string: '60 mins',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Blitz-3',
            turn_expiry: 0,
            total_time_per_side: 60*3, // 3 mins
            total_time_string: '3 mins',
            increment: 0
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Blitz-3-2',
            turn_expiry: 0,
            total_time_per_side: 60*3, // 3 mins
            total_time_string: '3 mins | 2s',
            increment: 2
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Blitz-5',
            turn_expiry: 0,
            total_time_per_side: 60*5, // 5 mins
            total_time_string: '5 mins',
            increment: 0
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Blitz-5-2',
            turn_expiry: 0,
            total_time_per_side: 60*5, // 5 mins
            total_time_string: '5 mins | 2s',
            increment: 2
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Blitz-5-5',
            turn_expiry: 0,
            total_time_per_side: 60*5, // 5 mins
            total_time_string: '5 mins | 5s',
            increment: 0
        );

        self.playable.addGameFormat(
            world: self.world(),
            description: 'Bullet-1',
            turn_expiry: 0,
            total_time_per_side: 60*1, // 1 min
            total_time_string: '1 min',
            increment: 0
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Bullet-1-1',
            turn_expiry: 0,
            total_time_per_side: 60*1, // 1 min
            total_time_string: '1 min | 1s',
            increment: 1
        );
        
        self.playable.addGameFormat(
            world: self.world(),
            description: 'Bullet-2-1',
            turn_expiry: 0,
            total_time_per_side: 60*2, // 2 min
            total_time_string: '2 min | 1s',
            increment: 1
        );

    }

    // impl: implement functions specified in trait
    #[abi(embed_v0)]
    impl AdminImpl of IAdmin<ContractState> {
        
        fn add_game_format(
            self: @ContractState,
            description: felt252, 
            turn_expiry: u64, 
            total_time_per_side: u64, 
            total_time_string: felt252, 
            increment: u8) {

            self.playable.addGameFormat(
                    world: self.world(),
                    description: description,
                    turn_expiry: turn_expiry,
                    total_time_per_side: total_time_per_side,
                    total_time_string: total_time_string,
                    increment: increment
            );
        }
        
        fn remove_game_format(
            self: @ContractState, format_id: u16) {
            self.playable.removeGameFormat(
                world: self.world(),
                format_id: format_id
            );
        }
    }


}
