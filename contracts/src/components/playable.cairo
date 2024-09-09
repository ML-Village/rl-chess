#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;
    use traits::{Into, TryInto};

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
    use rl_chess::models::index::{Player, Game, Format};
    use rl_chess::models::player::{PlayerTrait, PlayerAssert};
    use rl_chess::models::game::{GameTrait};
    use rl_chess::types::profile::ProfilePicType;

    // Errors

    mod errors {}

    // Storage

    #[storage]
    struct Storage {
        format_id: u16,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        
        fn registerPlayer(
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

        fn updatePlayer(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            address: ContractAddress,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64,
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            let mut player = store.get_player(address);
            player.profile_pic_type = profile_pic_type;
            player.profile_pic_uri = profile_pic_uri;
            store.set_player(player);
        }

        fn addGameFormat(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            description: felt252, 
            turn_expiry: u64, 
            total_time_per_side: u64, 
            total_time_string: felt252, 
            increment: u8
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);


            store.set_format(Format {
                format_id: (world.uuid() + 1).try_into().unwrap(),
                description,
                turn_expiry,
                total_time_per_side,
                total_time_string,
                increment
            });

        }

        fn removeGameFormat(
            self: @ComponentState<TContractState>, 
            world: IWorldDispatcher,
            format_id: u16,
        ){
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let gameFormat = store.get_format(format_id);
            store.delete_format(gameFormat);
        }
    }

}
