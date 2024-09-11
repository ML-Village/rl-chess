// Starknet imports

use starknet::ContractAddress;

// Dojo imports

use dojo::world::IWorldDispatcher;


// Interfaces

#[starknet::interface]
trait IRoom<TContractState> {
    fn move(
        self: @TContractState,
        game_id: u128,
        move_from: u8,
        move_to: u8,
        promotion: u8,
    );
}

// Contracts

#[dojo::contract]
mod room {
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
    impl RoomImpl of IRoom<ContractState> {

        fn move(
            self: @ContractState,
            game_id: u128,
            move_from: u8,
            move_to: u8,
            promotion: u8,
        ){
            self.playable.movePiece(
                world: self.world(),
                game_id: game_id,
                caller_address: get_caller_address(),
                move_from: move_from,
                move_to: move_to,
                promotion: promotion,
            );
        }

    }


}