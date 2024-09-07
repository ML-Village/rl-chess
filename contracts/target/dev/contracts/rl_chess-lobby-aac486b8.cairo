#[starknet::contract]
pub mod lobby {
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
            "lobby"
        }

        fn namespace(self: @ContractState) -> ByteArray {
            "rl_chess"
        }

        fn tag(self: @ContractState) -> ByteArray {
            "rl_chess-lobby"
        }

        fn name_hash(self: @ContractState) -> felt252 {
            229973454543114727866574277222284690692772446799889403184419435092149680199
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            521391545587964864438649656535115737286558186421403201930682034711360884972
        }

        fn selector(self: @ContractState) -> felt252 {
            301720375316093150846175429105383428582618045621575966546924377597765909551
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

    use super::ILobby;
    use rl_chess::types::profile::ProfilePicType;

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
    impl LobbyImpl of ILobby<ContractState> {
        fn register_player(
            self: @ContractState,
            name: felt252,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64
        ) {
            self
                .playable
                .register_player(
                    self.world(), get_caller_address(), name, profile_pic_type, profile_pic_uri
                );
        }
        fn update_player(
            self: @ContractState,
            name: felt252,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64
        ) {}
        fn invite(
            self: @ContractState,
            game_format_id: u16,
            invitee_address: ContractAddress,
            invite_expiry: u64
        ) -> u128 {
            88
        }
        fn reply_invite(self: @ContractState, game_id: u128, accepted: bool) -> bool {
            true
        }
        fn create_game(self: @ContractState, game_format_id: u16) -> u128 {
            88
        }
        fn join_game(self: @ContractState, game_id: u128) -> bool {
            true
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

