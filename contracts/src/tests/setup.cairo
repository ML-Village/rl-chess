mod setup {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::testing::{
        set_contract_address, set_caller_address, 
        set_block_number, set_block_timestamp };

    // Dojo imports

    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo::utils::test::{spawn_test_world};

    // Internal imports

    use rl_chess::models::index;
    use rl_chess::models::game::Game;
    use rl_chess::models::player::Player;
    use rl_chess::models::history::History;
    use rl_chess::models::format::Format;
    use rl_chess::models::board::Board;
    
    use rl_chess::types::profile::ProfilePicType;
    use rl_chess::systems::admin::{admin, 
        IAdmin, IAdminDispatcher, IAdminDispatcherTrait};
    use rl_chess::systems::lobby::{lobby, 
        ILobby, ILobbyDispatcher, ILobbyDispatcherTrait};
    use rl_chess::systems::room::{room, 
        IRoom, IRoomDispatcher, IRoomDispatcherTrait};

    // Constants
    const INITIAL_TIMESTAMP: u64 = 0x100000000;
    const INITIAL_STEP: u64 = 0x10;

    fn PLAYER() -> ContractAddress {
        starknet::contract_address_const::<'PLAYER'>()
    }

    fn ANYONE() -> ContractAddress {
        starknet::contract_address_const::<'ANYONE'>()
    }

    const PLAYER_NAME: felt252 = 'PLAYER_NAME';
    const ANYONE_NAME: felt252 = 'ANYONE_NAME';


    #[derive(Drop)]
    struct Systems {
        admin: IAdminDispatcher,
        lobby: ILobbyDispatcher,
        room: IRoomDispatcher,
    }

    #[derive(Drop)]
    struct Context {
        game_id: u128,
        player_id: ContractAddress,
        anyone_id: ContractAddress,
        player_name: felt252,
        anyone_name: felt252,
    }

    fn elapse_timestamp(delta: u64) -> (u64, u64) {
        let block_info = starknet::get_block_info().unbox();
        let new_block_number = block_info.block_number + 1;
        let new_block_timestamp = block_info.block_timestamp + delta;
        set_block_number(new_block_number);
        set_block_timestamp(new_block_timestamp);
        (new_block_number, new_block_timestamp)
    }

    #[inline(always)]
    fn create_game() -> (IWorldDispatcher, Systems, Context) {
        // [Setup] World
        let models = array![
            index::player::TEST_CLASS_HASH, 
            index::game::TEST_CLASS_HASH,
            index::board::TEST_CLASS_HASH,
            index::format::TEST_CLASS_HASH,
            index::history::TEST_CLASS_HASH,
            ];
        let world = spawn_test_world(array!["rl_chess"].span(), models.span());

        // [Setup] Systems'
        let admin_address = world
            .deploy_contract('salt_admin', admin::TEST_CLASS_HASH.try_into().unwrap());
        let lobby_address = world
            .deploy_contract('salt_lobby', lobby::TEST_CLASS_HASH.try_into().unwrap());
        let room_address = world
            .deploy_contract('salt_room', room::TEST_CLASS_HASH.try_into().unwrap());

        let systems = Systems {
            admin: IAdminDispatcher { contract_address: admin_address },
            lobby: ILobbyDispatcher { contract_address: lobby_address },
            room: IRoomDispatcher { contract_address: room_address }
        };
        world.grant_writer(dojo::utils::bytearray_hash(@"rl_chess"), admin_address);
        world.grant_writer(dojo::utils::bytearray_hash(@"rl_chess"), lobby_address);
        world.grant_writer(dojo::utils::bytearray_hash(@"rl_chess"), room_address);
        world.grant_writer(dojo::utils::bytearray_hash(@"rl_chess"), PLAYER());

        // [Setup] Context
        set_block_timestamp(INITIAL_TIMESTAMP);
        set_contract_address(PLAYER());

        //0 . add game format
        systems.admin.add_game_format(
            description:'Daily-1',
            turn_expiry: 0,
            total_time_per_side: 60*60*24, // 1 day
            total_time_string: '1-day',
            increment: 0,
            available: true
        );

        // 1. register players
        println!("setup: registering player -> {}", PLAYER_NAME);
        starknet::get_execution_info().contract_address.print();
        let player = systems.lobby.register_player(PLAYER_NAME, ProfilePicType::Native, 1);
        
        set_contract_address(ANYONE());
        println!("setup: registering player -> {}", ANYONE_NAME);
        starknet::get_execution_info().contract_address.print();
        let anyone = systems.lobby.register_player(ANYONE_NAME, ProfilePicType::Native, 1);

        // 2. create game with player 1
        set_contract_address(PLAYER());
        let game_id = systems.lobby.create_invite_game(
            1,
            ANYONE(),
            1000000000000000000,
        );

        //let player_id = systems.lobby.create(PLAYER_NAME);
        //set_contract_address(ANYONE());
        //systems.actions.join(game_id, ANYONE_NAME);
        // let context = Context {
        //     player_id: PLAYER().into(),
        //     player_name: PLAYER_NAME,
        //     anyone_id: ANYONE().into(),
        //     anyone_name: ANYONE_NAME,
        //     game_id
        // };
        // set_contract_address(PLAYER());
        let context = Context {
            game_id: game_id,
            player_id: player.address,
            anyone_id: anyone.address,

            player_name: PLAYER_NAME,
            anyone_name: ANYONE_NAME,

        };
        // [Return]
        (world, systems, context)
    }

    fn ready_game() -> (IWorldDispatcher, Systems, Context) {
        let (world, systems, context) = create_game();
        elapse_timestamp(INITIAL_STEP);
        set_contract_address(ANYONE());
        systems.lobby.reply_invite(context.game_id, true);

        systems.lobby.ready_up(context.game_id);

        set_contract_address(PLAYER());
        systems.lobby.ready_up(context.game_id);

        (world, systems, context)
    }

    fn start_game() -> (IWorldDispatcher, Systems, Context) {
        let (world, systems, context) = ready_game();
        elapse_timestamp(INITIAL_STEP);
        set_contract_address(ANYONE());
        systems.lobby.start_game(context.game_id);

        (world, systems, context)
    }


}
