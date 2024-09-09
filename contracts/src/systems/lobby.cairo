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
    fn create_invite_game(
        self: @TContractState, 
        game_format_id: u16,
        invitee_address: ContractAddress,
        invite_expiry: u64
    );
    
    
    fn update_invitee(
        self: @TContractState,
        game_id: u128,
        invitee_address: ContractAddress,
        invite_expiry: u64,
    );
    
    fn reply_invite(
        self: @TContractState,
        game_id: u128,
        accepted: bool
    );
    
    // regular create/wait games
    fn create_game(
        self: @TContractState,
        game_format_id: u16,
        invite_expiry: u64,
    );

    fn join_game(
        self: @TContractState,
        game_id: u128
    );
    
    fn leave_game(
        self: @TContractState,
        game_id: u128,
    );
    
    fn ready_up(
        self: @TContractState,
        game_id: u128,
    );

    fn owner_withdraw_game(
        self: @TContractState,
        game_id: u128,
    );

    fn switch_sides(
        self: @TContractState,
        game_id: u128,
    );

    fn start_game(
        self: @TContractState,
        game_id: u128,
    );

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

        fn create_invite_game(
            self: @ContractState,
            game_format_id: u16,
            invitee_address: ContractAddress,
            invite_expiry: u64,
        ){

            self.playable.createInviteGame(
                world: self.world(),
                game_format_id: game_format_id,
                room_owner_address: get_caller_address(),
                invitee_address: invitee_address,
                invite_expiry: invite_expiry,
            );
        }

        fn update_invitee(
            self: @ContractState,
            game_id: u128,
            invitee_address: ContractAddress,
            invite_expiry: u64,
        ){
            self.playable.updateInvitee(
                world: self.world(),
                game_id: game_id,
                room_owner_address: get_caller_address(),
                invitee_address: invitee_address,
                invite_expiry: invite_expiry,
            );
        }

        fn reply_invite(
            self: @ContractState,
            game_id: u128,
            accepted: bool,
        ){
            self.playable.replyInvite(
                world: self.world(),
                invitee_address: get_caller_address(),
                game_id: game_id,
                accepted: accepted,
            );
        }

        fn create_game(
            self: @ContractState,
            game_format_id: u16,
            invite_expiry: u64,
        ){
            self.playable.createInviteGame(
                world: self.world(),
                game_format_id: game_format_id,
                room_owner_address: get_caller_address(),
                invitee_address: starknet::contract_address_const::<0x0>(),
                invite_expiry: invite_expiry,
            );
        }

        fn join_game(
            self: @ContractState,
            game_id: u128,
        ){
            self.playable.joinGame(
                world: self.world(),
                game_id: game_id,
                invitee_address: get_caller_address(),
            );
        }

        fn leave_game(
            self: @ContractState,
            game_id: u128,
        ){
            self.playable.leaveGame(
                world: self.world(),
                game_id: game_id,
                player_address: get_caller_address(),
            );
        }

        fn owner_withdraw_game(
            self: @ContractState,
            game_id: u128,
        ){
            self.playable.ownerWithdrawGame(
                world: self.world(),
                game_id: game_id,
                room_owner_address: get_caller_address(),
            );
        }

        fn ready_up(
            self: @ContractState,
            game_id: u128,
        ){
            self.playable.readyUp(
                world: self.world(),
                game_id: game_id,
                caller_address: get_caller_address(),
            );
        }

        fn start_game(
            self: @ContractState,
            game_id: u128,
        ){
            self.playable.startGame(
                world: self.world(),
                game_id: game_id,
                caller_address: get_caller_address(),
            );
        }

        fn switch_sides(
            self: @ContractState,
            game_id: u128,
        ){
            self.playable.switchSides(
                world: self.world(),
                game_id: game_id,
                caller_address: get_caller_address(),
            );
        }



    }
}
