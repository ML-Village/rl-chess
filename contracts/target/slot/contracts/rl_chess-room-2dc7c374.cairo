#[starknet::contract]
pub mod room {
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
            "room"
        }

        fn namespace(self: @ContractState) -> ByteArray {
            "rl_chess"
        }

        fn tag(self: @ContractState) -> ByteArray {
            "rl_chess-room"
        }

        fn name_hash(self: @ContractState) -> felt252 {
            2271931901853609209877918647356759585991299208792570067734407697604984086383
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            521391545587964864438649656535115737286558186421403201930682034711360884972
        }

        fn selector(self: @ContractState) -> felt252 {
            1294189359142653495124786263888725532975546951342167148287117709360926377762
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
    use starknet::ContractAddress;
    use starknet::info::{get_caller_address, get_block_timestamp};

    // Local imports

    use super::IRoom;

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

    // Implementations

    #[abi(embed_v0)]
    impl RoomImpl of IRoom<ContractState> {
        fn move(self: @ContractState, game_id: u128, move_from: u8, move_to: u8, promotion: u8) {
            self
                .playable
                .movePiece(
                    world: self.world(),
                    game_id: game_id,
                    caller_address: get_caller_address(),
                    move_from: move_from,
                    move_to: move_to,
                    promotion: promotion,
                );
        }
        fn get_fen(self: @ContractState, game_id: u128) -> ByteArray {
            self.playable.getFen(world: self.world(), game_id: game_id,)
        }
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
            );
            assert(
                self
                    .world()
                    .is_owner(self.selector(), starknet::get_tx_info().account_contract_address),
                'Only owner can init'
            );
        }
    }
}

