use starknet::ContractAddress;
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

use rl_chess::types::profile::ProfilePicType;


#[derive(Clone, Drop, Serde)]   // ByteArray is not copiable!
#[dojo::model]
pub struct Player {
    #[key]
    pub address: ContractAddress,   // wallet address
    //-----------------------
    pub name: felt252,
    pub profile_pic_type: ProfilePicType,
    pub profile_pic_uri: u64,     // can be anything 
    pub timestamp: u64,                 // date registered
}

