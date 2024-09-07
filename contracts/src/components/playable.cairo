#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::info::{get_caller_address, get_block_timestamp};
    use starknet::storage::Map as StorageMap;

    // Dojo imports

    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;

    // Internal imports

    use rl_chess::constants;
    use rl_chess::store::{Store, StoreTrait};
    use rl_chess::models::player::{Player, PlayerTrait, PlayerAssert};
    use rl_chess::types::profile::ProfilePicType;

    // Errors

    mod errors {}

    // Storage

    #[storage]
    struct Storage {}

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        
        fn register_player(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            address: ContractAddress,
            name: felt252,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64,
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            let player = PlayerTrait::new(address,name,profile_pic_type,profile_pic_uri);
            store.set_player(player);
        }
    }
}
