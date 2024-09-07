// Core imports

use core::debug::PrintTrait;
use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
use traits::{Into, TryInto};

// Inernal imports

//use rl_chess::constants::{};
use rl_chess::models::index::Player;
use rl_chess::types::profile::ProfilePicType;
use rl_chess::utils::short_string::{ShortStringTrait}; // for bytearray conversion from felt252

mod errors {
    const PLAYER_NOT_EXIST: felt252 = 'Player: does not exist';
    const PLAYER_ALREADY_EXIST: felt252 = 'Player: already exist';
    const PLAYER_INVALID_NAME: felt252 = 'Player: invalid name';
}

#[generate_trait]
impl PlayerImpl of PlayerTrait {
    #[inline]
    fn new(address: ContractAddress, 
        name: felt252, 
        profile_pic_type: ProfilePicType,
        profile_pic_uri: u64,) -> Player {
        // [Check] Name is valid
        assert(name != 0, errors::PLAYER_INVALID_NAME);
        // [Return] Player
        Player {
            address,
            name,
            profile_pic_type,
            profile_pic_uri: profile_pic_uri,
            timestamp: get_block_timestamp(),
        }
    }

}

#[generate_trait]
impl PlayerAssert of AssertTrait {
    #[inline]
    fn assert_exists(self: Player) {
        assert(0 != self.name, errors::PLAYER_NOT_EXIST);
    }

    #[inline]
    fn assert_not_exists(self: Player) {
        assert(0 == self.name, errors::PLAYER_ALREADY_EXIST);
    }
}

#[cfg(test)]
mod tests {
    // Local imports

    // use super::{
    //     Player, PlayerTrait, Role, Mode, ModeTrait, Direction, Monster, MonsterTrait,
    //     DEFAULT_PLAYER_DAMAGE, DEFAULT_PLAYER_HEALTH, DEFAULT_PLAYER_GOLD, DEFAULT_POTION_COST,
    //     DEFAULT_POTION_HEAL
    // };

    // // Constants

    // const ID: felt252 = 'ID';
    // const PLAYER_NAME: felt252 = 'Alice';
    // const TIME: u64 = 0;
    // const MODE: Mode = Mode::Easy;

    // #[test]
    // fn test_player_new() {
    //     let player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
    //     assert_eq!(player.id, ID);
    //     assert_eq!(player.name, PLAYER_NAME);
    //     assert_eq!(player.mode, MODE.into());
    //     assert_eq!(player.role, Role::None.into());
    //     assert_eq!(player.damage, DEFAULT_PLAYER_DAMAGE);
    //     assert_eq!(player.health, DEFAULT_PLAYER_HEALTH);
    //     assert_eq!(player.gold, DEFAULT_PLAYER_GOLD);
    //     assert_eq!(player.score, 0);
    // }

    // #[test]
    // fn test_player_enrole() {
    //     let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
    //     player.enrole(Role::Fire);
    //     assert_eq!(player.role, Role::Fire.into());
    // }

    // #[test]
    // fn test_player_move() {
    //     let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
    //     let seed = player.seed;
    //     player.move(Direction::Up);
    //     assert_eq!(seed, player.seed);
    // }

    // #[test]
    // fn test_player_take_damage() {
    //     let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
    //     player.take_damage(Role::Fire, 10);
    //     assert_eq!(player.health < DEFAULT_PLAYER_HEALTH, true);
    // }

    // #[test]
    // fn test_player_reward() {
    //     let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
    //     player.reward(10);
    //     assert_eq!(player.gold, DEFAULT_PLAYER_GOLD + 10);
    //     assert_eq!(player.score, 1);
    // }

    // #[test]
    // fn test_player_heal() {
    //     let mut player = PlayerTrait::new(ID, PLAYER_NAME, TIME, MODE);
    //     player.gold = DEFAULT_POTION_COST;
    //     player.heal(1);
    //     assert_eq!(player.gold, 0);
    //     assert_eq!(player.health, DEFAULT_PLAYER_HEALTH + DEFAULT_POTION_HEAL);
    // }
}

