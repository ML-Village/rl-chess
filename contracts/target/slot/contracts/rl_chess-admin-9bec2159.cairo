#[starknet::contract]
pub mod admin {
    use dojo::world;
    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;
    use dojo::world::IWorldProvider;
    use dojo::contract::IContract;
    use starknet::storage::{
        StorageMapReadAccess, StorageMapWriteAccess, StoragePointerReadAccess,
        StoragePointerWriteAccess
    };

    component!(
        path: dojo::contract::upgradeable::upgradeable,
        storage: upgradeable,
        event: UpgradeableEvent
    );

    #[abi(embed_v0)]
    pub impl ContractImpl of IContract<ContractState> {
        fn contract_name(self: @ContractState) -> ByteArray {
            "admin"
        }

        fn namespace(self: @ContractState) -> ByteArray {
            "rl_chess"
        }

        fn tag(self: @ContractState) -> ByteArray {
            "rl_chess-admin"
        }

        fn name_hash(self: @ContractState) -> felt252 {
            3433736790505106325361879623565555353583328338492586270228536688552063625080
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            521391545587964864438649656535115737286558186421403201930682034711360884972
        }

        fn selector(self: @ContractState) -> felt252 {
            275491006301414377085829905059536906742774513006638609858122339945865352214
        }
    }

    #[abi(embed_v0)]
    impl WorldProviderImpl of IWorldProvider<ContractState> {
        fn world(self: @ContractState) -> IWorldDispatcher {
            self.world_dispatcher.read()
        }
    }

    #[abi(embed_v0)]
    impl UpgradableImpl =
        dojo::contract::upgradeable::upgradeable::UpgradableImpl<ContractState>;

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

    #[storage]
    struct Storage {
        world_dispatcher: IWorldDispatcher,
        #[substorage(v0)]
        upgradeable: dojo::contract::upgradeable::upgradeable::Storage,
        #[substorage(v0)]
        playable: PlayableComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: dojo::contract::upgradeable::upgradeable::Event,
        #[flat]
        PlayableEvent: PlayableComponent::Event
    }
    #[starknet::interface]
    trait IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState);
    }

    #[abi(embed_v0)]
    impl IDojoInitImpl of IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState) {
            assert(
                starknet::get_caller_address() == self.world().contract_address,
                'Only world can init'
            ); // initialize game formats

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Daily-1',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 60 * 24, // 1 day
                    total_time_string: '1-day',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Daily-2',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 60 * 24 * 2, // 2 days
                    total_time_string: '2-days',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Daily-3',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 60 * 24 * 3, // 3 days
                    total_time_string: '3-days',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Daily-5',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 60 * 24 * 5, // 7 days
                    total_time_string: '5-days',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Daily-7',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 60 * 24 * 7, // 7 days
                    total_time_string: '7-days',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Daily-14',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 60 * 24 * 14, // 14 days
                    total_time_string: '14-days',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Rapid-10',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 10, // 15 minutes
                    total_time_string: '10-mins',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Rapid-10-5',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 10, // 15 minutes
                    total_time_string: '10 mins | 5s',
                    increment: 5,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Rapid-15',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 15, // 15 minutes
                    total_time_string: '15-mins',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Rapid-20',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 20, // 15 minutes
                    total_time_string: '20  mins',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Rapid-30',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 30, // 15 minutes
                    total_time_string: '30 mins',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Rapid-60',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 60, // 60 minutes
                    total_time_string: '60 mins',
                    increment: 0,
                    available: true
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Blitz-3',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 3, // 3 mins
                    total_time_string: '3 mins',
                    increment: 0,
                    available: false
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Blitz-3-2',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 3, // 3 mins
                    total_time_string: '3 mins | 2s',
                    increment: 2,
                    available: false
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Blitz-5',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 5, // 5 mins
                    total_time_string: '5 mins',
                    increment: 0,
                    available: false
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Blitz-5-2',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 5, // 5 mins
                    total_time_string: '5 mins | 2s',
                    increment: 2,
                    available: false
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Blitz-5-5',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 5, // 5 mins
                    total_time_string: '5 mins | 5s',
                    increment: 0,
                    available: false
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Bullet-1',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 1, // 1 min
                    total_time_string: '1 min',
                    increment: 0,
                    available: false
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Bullet-1-1',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 1, // 1 min
                    total_time_string: '1 min | 1s',
                    increment: 1,
                    available: false
                );

            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: 'Bullet-2-1',
                    turn_expiry: 0,
                    total_time_per_side: 60 * 2, // 2 min
                    total_time_string: '2 min | 1s',
                    increment: 1,
                    available: false
                );
        }
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
            increment: u8,
            available: bool
        ) {
            self
                .playable
                .addGameFormat(
                    world: self.world(),
                    description: description,
                    turn_expiry: turn_expiry,
                    total_time_per_side: total_time_per_side,
                    total_time_string: total_time_string,
                    increment: increment,
                    available: available
                );
        }
        fn remove_game_format(self: @ContractState, format_id: u16) {
            self.playable.removeGameFormat(world: self.world(), format_id: format_id);
        }
    }
}

