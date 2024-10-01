impl GameIntrospect<> of dojo::model::introspect::Introspect<Game<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        let sizes: Array<Option<usize>> = array![
            dojo::model::introspect::Introspect::<GameState>::size(),
            dojo::model::introspect::Introspect::<Color>::size(),
            Option::Some(20)
        ];

        if dojo::utils::any_none(@sizes) {
            return Option::None;
        }
        Option::Some(dojo::utils::sum(sizes))
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 666555013544114222811502754664953281991621585632988715334175726142098266317,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 653403138564337550926229906706817101235933311057749668911334078936812379159,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 238704008566700519653513577172356319692988836682250399242048828576641454255,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 892071252258352599489617485015270071931703561662803444561625071408421519870,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1079156002406974199836992124643527924228017207442047481397088912152826879846,
                    layout: dojo::model::introspect::Introspect::<ContractAddress>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1096502889037206039465137094112406567709133415834361810572773750917500450815,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 447602213658830047453473784476221937879462645897977630435043644639936205551,
                    layout: dojo::model::introspect::Introspect::<ContractAddress>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1741959091638263824874552170244384128952490456211179062514201962829835629575,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1696005132238063652220497984701649952657244343257428406259138916290170936017,
                    layout: dojo::model::introspect::Introspect::<ContractAddress>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 789845191252793380117612919503782014166675611936010128575340255600910546909,
                    layout: dojo::model::introspect::Introspect::<ContractAddress>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1132575818468362486301128701852010075184899188241625268663894689070780769234,
                    layout: dojo::model::introspect::Introspect::<GameState>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 103941454445696498963735236556955749456637088824093989546942220151152736663,
                    layout: dojo::model::introspect::Introspect::<bool>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 196191199453651709496881127518259975178349359897052348919949955596255134911,
                    layout: dojo::model::introspect::Introspect::<bool>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1052542359950857404976588542637228142927942684039054790010627980800810775724,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1073537071210185165706294336833528114707281554320288027937273801304619092066,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 784638576644285732703873291112602799497164844748070364705073756028033233077,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 209575198672692611156608439965777823663031187380478293281392230332892495531,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1519184188231093755957115246119276487121618932230874359361964111464199949938,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1122785356558245749211844979892528260958762730732922551848111421499268806969,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 219186728921007360201595850127576360049656246336195436562291659965961844359,
                    layout: dojo::model::introspect::Introspect::<Color>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1216729249298636368797238062632141198510729091867131409898934543796314411976,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1748227330065814545670367226187486423266152570031718111236803079772826266540,
                    layout: dojo::model::introspect::Introspect::<ContractAddress>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'Game',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'game_id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<u128>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'game_format_id',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'w_turn_expiry_time',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'b_turn_expiry_time',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'invite_expiry',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'room_owner_address',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'owner_elo',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'invitee_address',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'invitee_elo',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'white_player_address',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'black_player_address',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'game_state',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<GameState>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'owner_ready',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<bool>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'invitee_ready',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<bool>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'room_start',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'room_end',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'w_last_move_time',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'b_last_move_time',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'w_total_time_left',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'b_total_time_left',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'side_to_move',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<Color>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'result',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'winner',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<ContractAddress>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct GameEntity {
    __id: felt252, // private field
    pub game_format_id: u16,
    pub w_turn_expiry_time: u64,
    pub b_turn_expiry_time: u64,
    pub invite_expiry: u64,
    pub room_owner_address: ContractAddress,
    pub owner_elo: u16,
    pub invitee_address: ContractAddress,
    pub invitee_elo: u16,
    pub white_player_address: ContractAddress,
    pub black_player_address: ContractAddress,
    pub game_state: GameState,
    pub owner_ready: bool,
    pub invitee_ready: bool,
    pub room_start: u64,
    pub room_end: u64,
    pub w_last_move_time: u64,
    pub b_last_move_time: u64,
    pub w_total_time_left: u64,
    pub b_total_time_left: u64,
    pub side_to_move: Color,
    pub result: u8,
    pub winner: ContractAddress,
}

#[generate_trait]
pub impl GameEntityStoreImpl of GameEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> GameEntity {
        GameModelEntityImpl::get(world, entity_id)
    }


    fn get_game_format_id(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            666555013544114222811502754664953281991621585632988715334175726142098266317
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Game::game_format_id`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_game_format_id(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                666555013544114222811502754664953281991621585632988715334175726142098266317,
                serialized.span()
            );
    }

    fn get_w_turn_expiry_time(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            653403138564337550926229906706817101235933311057749668911334078936812379159
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::w_turn_expiry_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_w_turn_expiry_time(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                653403138564337550926229906706817101235933311057749668911334078936812379159,
                serialized.span()
            );
    }

    fn get_b_turn_expiry_time(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            238704008566700519653513577172356319692988836682250399242048828576641454255
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::b_turn_expiry_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_b_turn_expiry_time(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                238704008566700519653513577172356319692988836682250399242048828576641454255,
                serialized.span()
            );
    }

    fn get_invite_expiry(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            892071252258352599489617485015270071931703561662803444561625071408421519870
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::invite_expiry`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_invite_expiry(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                892071252258352599489617485015270071931703561662803444561625071408421519870,
                serialized.span()
            );
    }

    fn get_room_owner_address(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ContractAddress {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1079156002406974199836992124643527924228017207442047481397088912152826879846
        );
        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::room_owner_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_room_owner_address(
        self: @GameEntity, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1079156002406974199836992124643527924228017207442047481397088912152826879846,
                serialized.span()
            );
    }

    fn get_owner_elo(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1096502889037206039465137094112406567709133415834361810572773750917500450815
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Game::owner_elo`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_owner_elo(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1096502889037206039465137094112406567709133415834361810572773750917500450815,
                serialized.span()
            );
    }

    fn get_invitee_address(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ContractAddress {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            447602213658830047453473784476221937879462645897977630435043644639936205551
        );
        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::invitee_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_invitee_address(
        self: @GameEntity, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                447602213658830047453473784476221937879462645897977630435043644639936205551,
                serialized.span()
            );
    }

    fn get_invitee_elo(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1741959091638263824874552170244384128952490456211179062514201962829835629575
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Game::invitee_elo`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_invitee_elo(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1741959091638263824874552170244384128952490456211179062514201962829835629575,
                serialized.span()
            );
    }

    fn get_white_player_address(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ContractAddress {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1696005132238063652220497984701649952657244343257428406259138916290170936017
        );
        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::white_player_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_white_player_address(
        self: @GameEntity, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1696005132238063652220497984701649952657244343257428406259138916290170936017,
                serialized.span()
            );
    }

    fn get_black_player_address(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ContractAddress {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            789845191252793380117612919503782014166675611936010128575340255600910546909
        );
        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::black_player_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_black_player_address(
        self: @GameEntity, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                789845191252793380117612919503782014166675611936010128575340255600910546909,
                serialized.span()
            );
    }

    fn get_game_state(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> GameState {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1132575818468362486301128701852010075184899188241625268663894689070780769234
        );
        let field_value = core::serde::Serde::<GameState>::deserialize(ref values);

        if core::option::OptionTrait::<GameState>::is_none(@field_value) {
            panic!("Field `Game::game_state`: deserialization failed.");
        }

        core::option::OptionTrait::<GameState>::unwrap(field_value)
    }

    fn set_game_state(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: GameState) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1132575818468362486301128701852010075184899188241625268663894689070780769234,
                serialized.span()
            );
    }

    fn get_owner_ready(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> bool {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            103941454445696498963735236556955749456637088824093989546942220151152736663
        );
        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `Game::owner_ready`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_owner_ready(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: bool) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                103941454445696498963735236556955749456637088824093989546942220151152736663,
                serialized.span()
            );
    }

    fn get_invitee_ready(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> bool {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            196191199453651709496881127518259975178349359897052348919949955596255134911
        );
        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `Game::invitee_ready`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_invitee_ready(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: bool) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                196191199453651709496881127518259975178349359897052348919949955596255134911,
                serialized.span()
            );
    }

    fn get_room_start(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1052542359950857404976588542637228142927942684039054790010627980800810775724
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::room_start`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_room_start(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1052542359950857404976588542637228142927942684039054790010627980800810775724,
                serialized.span()
            );
    }

    fn get_room_end(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1073537071210185165706294336833528114707281554320288027937273801304619092066
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::room_end`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_room_end(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1073537071210185165706294336833528114707281554320288027937273801304619092066,
                serialized.span()
            );
    }

    fn get_w_last_move_time(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            784638576644285732703873291112602799497164844748070364705073756028033233077
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::w_last_move_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_w_last_move_time(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                784638576644285732703873291112602799497164844748070364705073756028033233077,
                serialized.span()
            );
    }

    fn get_b_last_move_time(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            209575198672692611156608439965777823663031187380478293281392230332892495531
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::b_last_move_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_b_last_move_time(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                209575198672692611156608439965777823663031187380478293281392230332892495531,
                serialized.span()
            );
    }

    fn get_w_total_time_left(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1519184188231093755957115246119276487121618932230874359361964111464199949938
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::w_total_time_left`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_w_total_time_left(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1519184188231093755957115246119276487121618932230874359361964111464199949938,
                serialized.span()
            );
    }

    fn get_b_total_time_left(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1122785356558245749211844979892528260958762730732922551848111421499268806969
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::b_total_time_left`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_b_total_time_left(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1122785356558245749211844979892528260958762730732922551848111421499268806969,
                serialized.span()
            );
    }

    fn get_side_to_move(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> Color {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            219186728921007360201595850127576360049656246336195436562291659965961844359
        );
        let field_value = core::serde::Serde::<Color>::deserialize(ref values);

        if core::option::OptionTrait::<Color>::is_none(@field_value) {
            panic!("Field `Game::side_to_move`: deserialization failed.");
        }

        core::option::OptionTrait::<Color>::unwrap(field_value)
    }

    fn set_side_to_move(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: Color) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                219186728921007360201595850127576360049656246336195436562291659965961844359,
                serialized.span()
            );
    }

    fn get_result(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1216729249298636368797238062632141198510729091867131409898934543796314411976
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Game::result`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_result(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1216729249298636368797238062632141198510729091867131409898934543796314411976,
                serialized.span()
            );
    }

    fn get_winner(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> ContractAddress {
        let mut values = dojo::model::ModelEntity::<
            GameEntity
        >::get_member(
            world,
            entity_id,
            1748227330065814545670367226187486423266152570031718111236803079772826266540
        );
        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::winner`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_winner(self: @GameEntity, world: dojo::world::IWorldDispatcher, value: ContractAddress) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1748227330065814545670367226187486423266152570031718111236803079772826266540,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl GameStoreImpl of GameStore {
    fn entity_id_from_keys(game_id: u128) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> Game {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Game>::deserialize(ref serialized);

        if core::option::OptionTrait::<Game>::is_none(@entity) {
            panic!(
                "Model `Game`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Game>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, game_id: u128) -> Game {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        dojo::model::Model::<Game>::get(world, serialized.span())
    }


    fn get_game_format_id(world: dojo::world::IWorldDispatcher, game_id: u128) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            666555013544114222811502754664953281991621585632988715334175726142098266317
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Game::game_format_id`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_game_format_id(self: @Game, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                666555013544114222811502754664953281991621585632988715334175726142098266317,
                serialized.span()
            );
    }

    fn get_w_turn_expiry_time(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            653403138564337550926229906706817101235933311057749668911334078936812379159
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::w_turn_expiry_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_w_turn_expiry_time(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                653403138564337550926229906706817101235933311057749668911334078936812379159,
                serialized.span()
            );
    }

    fn get_b_turn_expiry_time(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            238704008566700519653513577172356319692988836682250399242048828576641454255
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::b_turn_expiry_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_b_turn_expiry_time(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                238704008566700519653513577172356319692988836682250399242048828576641454255,
                serialized.span()
            );
    }

    fn get_invite_expiry(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            892071252258352599489617485015270071931703561662803444561625071408421519870
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::invite_expiry`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_invite_expiry(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                892071252258352599489617485015270071931703561662803444561625071408421519870,
                serialized.span()
            );
    }

    fn get_room_owner_address(
        world: dojo::world::IWorldDispatcher, game_id: u128
    ) -> ContractAddress {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1079156002406974199836992124643527924228017207442047481397088912152826879846
        );

        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::room_owner_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_room_owner_address(
        self: @Game, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1079156002406974199836992124643527924228017207442047481397088912152826879846,
                serialized.span()
            );
    }

    fn get_owner_elo(world: dojo::world::IWorldDispatcher, game_id: u128) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1096502889037206039465137094112406567709133415834361810572773750917500450815
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Game::owner_elo`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_owner_elo(self: @Game, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1096502889037206039465137094112406567709133415834361810572773750917500450815,
                serialized.span()
            );
    }

    fn get_invitee_address(world: dojo::world::IWorldDispatcher, game_id: u128) -> ContractAddress {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            447602213658830047453473784476221937879462645897977630435043644639936205551
        );

        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::invitee_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_invitee_address(
        self: @Game, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                447602213658830047453473784476221937879462645897977630435043644639936205551,
                serialized.span()
            );
    }

    fn get_invitee_elo(world: dojo::world::IWorldDispatcher, game_id: u128) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1741959091638263824874552170244384128952490456211179062514201962829835629575
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Game::invitee_elo`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_invitee_elo(self: @Game, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1741959091638263824874552170244384128952490456211179062514201962829835629575,
                serialized.span()
            );
    }

    fn get_white_player_address(
        world: dojo::world::IWorldDispatcher, game_id: u128
    ) -> ContractAddress {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1696005132238063652220497984701649952657244343257428406259138916290170936017
        );

        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::white_player_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_white_player_address(
        self: @Game, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1696005132238063652220497984701649952657244343257428406259138916290170936017,
                serialized.span()
            );
    }

    fn get_black_player_address(
        world: dojo::world::IWorldDispatcher, game_id: u128
    ) -> ContractAddress {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            789845191252793380117612919503782014166675611936010128575340255600910546909
        );

        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::black_player_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_black_player_address(
        self: @Game, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                789845191252793380117612919503782014166675611936010128575340255600910546909,
                serialized.span()
            );
    }

    fn get_game_state(world: dojo::world::IWorldDispatcher, game_id: u128) -> GameState {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1132575818468362486301128701852010075184899188241625268663894689070780769234
        );

        let field_value = core::serde::Serde::<GameState>::deserialize(ref values);

        if core::option::OptionTrait::<GameState>::is_none(@field_value) {
            panic!("Field `Game::game_state`: deserialization failed.");
        }

        core::option::OptionTrait::<GameState>::unwrap(field_value)
    }

    fn set_game_state(self: @Game, world: dojo::world::IWorldDispatcher, value: GameState) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1132575818468362486301128701852010075184899188241625268663894689070780769234,
                serialized.span()
            );
    }

    fn get_owner_ready(world: dojo::world::IWorldDispatcher, game_id: u128) -> bool {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            103941454445696498963735236556955749456637088824093989546942220151152736663
        );

        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `Game::owner_ready`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_owner_ready(self: @Game, world: dojo::world::IWorldDispatcher, value: bool) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                103941454445696498963735236556955749456637088824093989546942220151152736663,
                serialized.span()
            );
    }

    fn get_invitee_ready(world: dojo::world::IWorldDispatcher, game_id: u128) -> bool {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            196191199453651709496881127518259975178349359897052348919949955596255134911
        );

        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `Game::invitee_ready`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_invitee_ready(self: @Game, world: dojo::world::IWorldDispatcher, value: bool) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                196191199453651709496881127518259975178349359897052348919949955596255134911,
                serialized.span()
            );
    }

    fn get_room_start(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1052542359950857404976588542637228142927942684039054790010627980800810775724
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::room_start`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_room_start(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1052542359950857404976588542637228142927942684039054790010627980800810775724,
                serialized.span()
            );
    }

    fn get_room_end(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1073537071210185165706294336833528114707281554320288027937273801304619092066
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::room_end`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_room_end(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1073537071210185165706294336833528114707281554320288027937273801304619092066,
                serialized.span()
            );
    }

    fn get_w_last_move_time(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            784638576644285732703873291112602799497164844748070364705073756028033233077
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::w_last_move_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_w_last_move_time(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                784638576644285732703873291112602799497164844748070364705073756028033233077,
                serialized.span()
            );
    }

    fn get_b_last_move_time(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            209575198672692611156608439965777823663031187380478293281392230332892495531
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::b_last_move_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_b_last_move_time(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                209575198672692611156608439965777823663031187380478293281392230332892495531,
                serialized.span()
            );
    }

    fn get_w_total_time_left(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1519184188231093755957115246119276487121618932230874359361964111464199949938
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::w_total_time_left`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_w_total_time_left(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1519184188231093755957115246119276487121618932230874359361964111464199949938,
                serialized.span()
            );
    }

    fn get_b_total_time_left(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1122785356558245749211844979892528260958762730732922551848111421499268806969
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Game::b_total_time_left`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_b_total_time_left(self: @Game, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1122785356558245749211844979892528260958762730732922551848111421499268806969,
                serialized.span()
            );
    }

    fn get_side_to_move(world: dojo::world::IWorldDispatcher, game_id: u128) -> Color {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            219186728921007360201595850127576360049656246336195436562291659965961844359
        );

        let field_value = core::serde::Serde::<Color>::deserialize(ref values);

        if core::option::OptionTrait::<Color>::is_none(@field_value) {
            panic!("Field `Game::side_to_move`: deserialization failed.");
        }

        core::option::OptionTrait::<Color>::unwrap(field_value)
    }

    fn set_side_to_move(self: @Game, world: dojo::world::IWorldDispatcher, value: Color) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                219186728921007360201595850127576360049656246336195436562291659965961844359,
                serialized.span()
            );
    }

    fn get_result(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1216729249298636368797238062632141198510729091867131409898934543796314411976
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Game::result`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_result(self: @Game, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1216729249298636368797238062632141198510729091867131409898934543796314411976,
                serialized.span()
            );
    }

    fn get_winner(world: dojo::world::IWorldDispatcher, game_id: u128) -> ContractAddress {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Game
        >::get_member(
            world,
            serialized.span(),
            1748227330065814545670367226187486423266152570031718111236803079772826266540
        );

        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Game::winner`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_winner(self: @Game, world: dojo::world::IWorldDispatcher, value: ContractAddress) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1748227330065814545670367226187486423266152570031718111236803079772826266540,
                serialized.span()
            );
    }
}

pub impl GameModelEntityImpl of dojo::model::ModelEntity<GameEntity> {
    fn id(self: @GameEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @GameEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.game_format_id, ref serialized);
        core::serde::Serde::serialize(self.w_turn_expiry_time, ref serialized);
        core::serde::Serde::serialize(self.b_turn_expiry_time, ref serialized);
        core::serde::Serde::serialize(self.invite_expiry, ref serialized);
        core::serde::Serde::serialize(self.room_owner_address, ref serialized);
        core::serde::Serde::serialize(self.owner_elo, ref serialized);
        core::serde::Serde::serialize(self.invitee_address, ref serialized);
        core::serde::Serde::serialize(self.invitee_elo, ref serialized);
        core::serde::Serde::serialize(self.white_player_address, ref serialized);
        core::serde::Serde::serialize(self.black_player_address, ref serialized);
        core::serde::Serde::serialize(self.game_state, ref serialized);
        core::serde::Serde::serialize(self.owner_ready, ref serialized);
        core::serde::Serde::serialize(self.invitee_ready, ref serialized);
        core::serde::Serde::serialize(self.room_start, ref serialized);
        core::serde::Serde::serialize(self.room_end, ref serialized);
        core::serde::Serde::serialize(self.w_last_move_time, ref serialized);
        core::serde::Serde::serialize(self.b_last_move_time, ref serialized);
        core::serde::Serde::serialize(self.w_total_time_left, ref serialized);
        core::serde::Serde::serialize(self.b_total_time_left, ref serialized);
        core::serde::Serde::serialize(self.side_to_move, ref serialized);
        core::serde::Serde::serialize(self.result, ref serialized);
        core::serde::Serde::serialize(self.winner, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> GameEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<GameEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<GameEntity>::is_none(@entity_values) {
            panic!("ModelEntity `GameEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<GameEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> GameEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<Game>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<Game>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @GameEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<Game>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Game>::layout()
        );
    }

    fn delete(self: @GameEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<Game>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Game>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Game>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<Game>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @GameEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Game>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<Game>::selector(),
                    dojo::model::ModelIndex::MemberId((self.id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }
}

pub impl GameModelImpl of dojo::model::Model<Game> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> Game {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        GameStore::from_values(ref _keys, ref values)
    }

    fn set(self: @Game, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @Game, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(Self::keys(self)), Self::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, keys: Span<felt252>, member_id: felt252
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(Self::layout(), member_id) {
            Option::Some(field_layout) => {
                let entity_id = dojo::utils::entity_id_from_keys(keys);
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    Self::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @Game, world: dojo::world::IWorldDispatcher, member_id: felt252, values: Span<felt252>
    ) {
        match dojo::utils::find_model_field_layout(Self::layout(), member_id) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    Self::selector(),
                    dojo::model::ModelIndex::MemberId((self.entity_id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "Game"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "rl_chess"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "rl_chess-Game"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        1532908150713493975298925861626355615622116190753208638839208164237378392386
    }

    #[inline(always)]
    fn instance_selector(self: @Game) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        1006441281370197457275759734336188031449125414124572534775923241612880266379
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        521391545587964864438649656535115737286558186421403201930682034711360884972
    }

    #[inline(always)]
    fn entity_id(self: @Game) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @Game) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.game_id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Game) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.game_format_id, ref serialized);
        core::serde::Serde::serialize(self.w_turn_expiry_time, ref serialized);
        core::serde::Serde::serialize(self.b_turn_expiry_time, ref serialized);
        core::serde::Serde::serialize(self.invite_expiry, ref serialized);
        core::serde::Serde::serialize(self.room_owner_address, ref serialized);
        core::serde::Serde::serialize(self.owner_elo, ref serialized);
        core::serde::Serde::serialize(self.invitee_address, ref serialized);
        core::serde::Serde::serialize(self.invitee_elo, ref serialized);
        core::serde::Serde::serialize(self.white_player_address, ref serialized);
        core::serde::Serde::serialize(self.black_player_address, ref serialized);
        core::serde::Serde::serialize(self.game_state, ref serialized);
        core::serde::Serde::serialize(self.owner_ready, ref serialized);
        core::serde::Serde::serialize(self.invitee_ready, ref serialized);
        core::serde::Serde::serialize(self.room_start, ref serialized);
        core::serde::Serde::serialize(self.room_end, ref serialized);
        core::serde::Serde::serialize(self.w_last_move_time, ref serialized);
        core::serde::Serde::serialize(self.b_last_move_time, ref serialized);
        core::serde::Serde::serialize(self.w_total_time_left, ref serialized);
        core::serde::Serde::serialize(self.b_total_time_left, ref serialized);
        core::serde::Serde::serialize(self.side_to_move, ref serialized);
        core::serde::Serde::serialize(self.result, ref serialized);
        core::serde::Serde::serialize(self.winner, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<Game>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Game) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[starknet::interface]
pub trait Igame<T> {
    fn ensure_abi(self: @T, model: Game);
}

#[starknet::contract]
pub mod game {
    use super::Game;
    use super::Igame;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Game>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Game>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Game>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Game>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Game>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Game>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Game>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<Game>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Game>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<Game>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<Game>::ty()
        }
    }

    #[abi(embed_v0)]
    impl gameImpl of Igame<ContractState> {
        fn ensure_abi(self: @ContractState, model: Game) {}
    }
}
