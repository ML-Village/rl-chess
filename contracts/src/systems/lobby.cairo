// Starknet imports

use starknet::ContractAddress;

// Dojo imports

use dojo::world::IWorldDispatcher;

// Internal imports
use rl_chess::types::profile::ProfilePicType;

// Interfaces

#[starknet::interface]
trait ILobby<TContractState> {
        
    // Duelists
    fn register_player(
        self: @TContractState,
        name: felt252,
        profile_pic_type: ProfilePicType,
        profile_pic_uri: u64
    );

    fn update_player(
        self: @TContractState,
        profile_pic_type: ProfilePicType,
        profile_pic_uri: u64,
    );

    // do an invite
    fn invite(
        self: @TContractState, 
        game_format_id: u16,
        invitee_address: ContractAddress,
        invite_expiry: u64) -> u128;
    
    
    fn reply_invite(
        self: @TContractState,
        game_id: u128,
        accepted: bool) -> bool;
    
    // regular create/wait games
    fn create_game(
        self: @TContractState,
        game_format_id: u16) -> u128;

    fn join_game(
        self: @TContractState,
        game_id: u128) -> bool;
}

// Contracts

#[dojo::contract]
mod lobby {
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

    // Implementations

    #[abi(embed_v0)]
    impl LobbyImpl of ILobby<ContractState> {
        fn register_player(
            self: @ContractState,
            name: felt252,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64,
        ){
            self.playable.registerPlayer(
                world: self.world(),
                address: get_caller_address(),
                name: name, 
                profile_pic_type: profile_pic_type, 
                profile_pic_uri: profile_pic_uri);
        }

        fn update_player(
            self: @ContractState,
            profile_pic_type: ProfilePicType,
            profile_pic_uri: u64,
        ){
            self.playable.updatePlayer(
                world: self.world(),
                address: get_caller_address(),
                profile_pic_type: profile_pic_type,
                profile_pic_uri: profile_pic_uri,
            );
        }

        fn invite(
            self: @ContractState,
            game_format_id: u16,
            invitee_address: ContractAddress,
            invite_expiry: u64,
        ) -> u128 {
            88
        }

        fn reply_invite(
            self: @ContractState,
            game_id: u128,
            accepted: bool,
        ) -> bool {
            true
        }

        fn create_game(
            self: @ContractState,
            game_format_id: u16,
        ) -> u128 {
            88
        }

        fn join_game(
            self: @ContractState,
            game_id: u128,
        ) -> bool {
            true
        }


    }
}
