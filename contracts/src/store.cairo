//! Store struct and component management methods.

// Core imports

use core::debug::PrintTrait;

// starknet
use starknet::ContractAddress;

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Models imports
use rl_chess::models::player::{Player, PlayerTrait};

// Structs

#[derive(Copy, Drop)]
struct Store {
    world: IWorldDispatcher,
}

// Implementations

#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline]
    fn new(world: IWorldDispatcher) -> Store {
        Store { world: world }
    }

    #[inline]
    fn get_state(self: Store, player_id: felt252) {
    //->(Player, Dungeon) {
        //get!(self.world, player_id, (Player, Dungeon))
    }

    #[inline]
    fn get_player(self: Store, address: ContractAddress)-> Player {
        get!(self.world, address, (Player))
    }

    #[inline]
    fn set_state(self: Store, player: Player) {
        //set!(self.world, (player))
    }

    #[inline]
    fn set_player(self: Store, player: Player) {
        set!(self.world, (player))
    }

    // #[inline]
    // fn set_dungeon(self: Store, dungeon: Dungeon) {
    //     set!(self.world, (dungeon))
    // }
}
