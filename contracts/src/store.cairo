//! Store struct and component management methods.

// Core imports

use core::debug::PrintTrait;

// starknet
use starknet::ContractAddress;

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Models imports
use rl_chess::models::index::{ Player, Game, Format, Board, History };
use rl_chess::models::player::{PlayerTrait};
use rl_chess::models::game::{GameTrait};
use rl_chess::models::board::{BoardTrait};
use rl_chess::models::history::{HistoryTrait};
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
    fn get_player(self: Store, address: ContractAddress)-> Player {
        get!(self.world, address, (Player))
    }

    #[inline]
    fn get_game(self: Store, game_id: u128)-> Game {
        get!(self.world, game_id, (Game))
    }

    #[inline]
    fn get_format(self: Store, format_id: u16)-> Format {
        get!(self.world, format_id, (Format))
    }

    #[inline]
    fn get_board(self: Store, game_id: u128)-> Board {
        get!(self.world, game_id, (Board))
    }

    #[inline]
    fn get_history(self: Store, game_id: u128)-> History {
        get!(self.world, game_id, (History))
    }

    // ===== Setters ===== //

    #[inline]
    fn set_player(self: Store, player: Player) {
        set!(self.world, (player))
    }

    #[inline]
    fn set_game(self: Store, game: Game) {
        set!(self.world, (game))
    }

    #[inline]
    fn set_format(self: Store, format: Format) {
        set!(self.world, (format))
    }

    #[inline]
    fn set_board(self: Store, board: Board) {
        set!(self.world, (board))
    }

    #[inline]
    fn set_history(self: Store, history: History) {
        set!(self.world, (history))
    }


    #[inline]
    fn delete_format(self: Store, format: Format) {
        delete!(self.world, (format))
    }

}
