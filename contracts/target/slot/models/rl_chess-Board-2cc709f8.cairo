impl BoardIntrospect<> of dojo::model::introspect::Introspect<Board<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        let sizes: Array<Option<usize>> = array![
            dojo::model::introspect::Introspect::<Color>::size(), Option::Some(24)
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
                    selector: 1705747694706323992214073110905003089127935460542149574887662201533726654496,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1257392403772608673631340426028594634371267472295708634309463492722226221310,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 100445355683423868029133084390108563423105841002474524988821046859423425387,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1309926837780207986270435218142762630800874618540521825033981166840758962756,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 134188014602922373510402597182397164176587452352746481865596514775793337412,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 876986601864730550519389551774764061812796375965386567855544310760654525278,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1767614546545229912599907953021793784596741962193331625852449073201322421033,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1444815445559697790654470597664940970294153169701687558989190207649098248342,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1570679752520069770416622487903527459221732758604720482230447678406531618628,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 420810686662385673693121670188346434350575823793418534591370378522206067220,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1681133480864355967291797619808592261598395339595244218543873940592851677063,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 730023975432539360839218489316411865773448791798759994637818003564454615426,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1513494961604514621453896480852178111543090692384935660895844555065379157179,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 122552401468341525665204066950724674156166866093002278590527811377217398673,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 221545091880640491828820399347548094597669786126107928940054043377929918402,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 573244657489650197093614909284741346972421912946440170517924192805324023489,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 801229738062111143144136047211246573999633895585510722122970041945048082387,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1442751505475707605270398768161750420762449777359565191205580678010518251793,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 219186728921007360201595850127576360049656246336195436562291659965961844359,
                    layout: dojo::model::introspect::Introspect::<Color>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 796422278502036855146051949378412010081878452086589689800032250389441779389,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1607191152255112402547648874561628953695430356747805010487465139716100863533,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1645912678769656887811129682265879366585241648517227076438762504371653455357,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 911080323551738216805840859244168281848419522179145256528519470760599712350,
                    layout: dojo::model::introspect::Introspect::<u16>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 449576191080313162908646466795983098315361149202238691633125442058044204149,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 425069929092323778433013422746164427852026833574957853456062719464171507025,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'Board',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'game_id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<u128>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'whites',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'blacks',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'pawns',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'rooks',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'knights',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'bishops',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'queens',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'kings',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'wcp',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'wcr',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'wck',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'wcb',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'wcq',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'bcp',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'bcr',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'bck',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'bcb',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'bcq',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'side_to_move',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<Color>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'castling_rights',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'en_passant',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'halfmove_clock',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'fullmove_number',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'last_move_time',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'last_move_integer',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct BoardEntity {
    __id: felt252, // private field
    pub whites: u64,
    pub blacks: u64,
    pub pawns: u64,
    pub rooks: u64,
    pub knights: u64,
    pub bishops: u64,
    pub queens: u64,
    pub kings: u64,
    pub wcp: u8,
    pub wcr: u8,
    pub wck: u8,
    pub wcb: u8,
    pub wcq: u8,
    pub bcp: u8,
    pub bcr: u8,
    pub bck: u8,
    pub bcb: u8,
    pub bcq: u8,
    pub side_to_move: Color,
    pub castling_rights: u8,
    pub en_passant: u8,
    pub halfmove_clock: u8,
    pub fullmove_number: u16,
    pub last_move_time: u64,
    pub last_move_integer: u64,
}

#[generate_trait]
pub impl BoardEntityStoreImpl of BoardEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> BoardEntity {
        BoardModelEntityImpl::get(world, entity_id)
    }


    fn get_whites(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1705747694706323992214073110905003089127935460542149574887662201533726654496
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::whites`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_whites(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1705747694706323992214073110905003089127935460542149574887662201533726654496,
                serialized.span()
            );
    }

    fn get_blacks(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1257392403772608673631340426028594634371267472295708634309463492722226221310
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::blacks`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_blacks(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1257392403772608673631340426028594634371267472295708634309463492722226221310,
                serialized.span()
            );
    }

    fn get_pawns(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            100445355683423868029133084390108563423105841002474524988821046859423425387
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::pawns`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_pawns(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                100445355683423868029133084390108563423105841002474524988821046859423425387,
                serialized.span()
            );
    }

    fn get_rooks(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1309926837780207986270435218142762630800874618540521825033981166840758962756
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::rooks`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_rooks(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1309926837780207986270435218142762630800874618540521825033981166840758962756,
                serialized.span()
            );
    }

    fn get_knights(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            134188014602922373510402597182397164176587452352746481865596514775793337412
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::knights`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_knights(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                134188014602922373510402597182397164176587452352746481865596514775793337412,
                serialized.span()
            );
    }

    fn get_bishops(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            876986601864730550519389551774764061812796375965386567855544310760654525278
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::bishops`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_bishops(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                876986601864730550519389551774764061812796375965386567855544310760654525278,
                serialized.span()
            );
    }

    fn get_queens(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1767614546545229912599907953021793784596741962193331625852449073201322421033
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::queens`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_queens(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1767614546545229912599907953021793784596741962193331625852449073201322421033,
                serialized.span()
            );
    }

    fn get_kings(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1444815445559697790654470597664940970294153169701687558989190207649098248342
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::kings`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_kings(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1444815445559697790654470597664940970294153169701687558989190207649098248342,
                serialized.span()
            );
    }

    fn get_wcp(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1570679752520069770416622487903527459221732758604720482230447678406531618628
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcp`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcp(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1570679752520069770416622487903527459221732758604720482230447678406531618628,
                serialized.span()
            );
    }

    fn get_wcr(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            420810686662385673693121670188346434350575823793418534591370378522206067220
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcr`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcr(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                420810686662385673693121670188346434350575823793418534591370378522206067220,
                serialized.span()
            );
    }

    fn get_wck(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1681133480864355967291797619808592261598395339595244218543873940592851677063
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wck`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wck(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1681133480864355967291797619808592261598395339595244218543873940592851677063,
                serialized.span()
            );
    }

    fn get_wcb(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            730023975432539360839218489316411865773448791798759994637818003564454615426
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcb`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcb(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                730023975432539360839218489316411865773448791798759994637818003564454615426,
                serialized.span()
            );
    }

    fn get_wcq(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1513494961604514621453896480852178111543090692384935660895844555065379157179
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcq`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcq(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1513494961604514621453896480852178111543090692384935660895844555065379157179,
                serialized.span()
            );
    }

    fn get_bcp(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            122552401468341525665204066950724674156166866093002278590527811377217398673
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcp`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcp(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                122552401468341525665204066950724674156166866093002278590527811377217398673,
                serialized.span()
            );
    }

    fn get_bcr(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            221545091880640491828820399347548094597669786126107928940054043377929918402
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcr`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcr(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                221545091880640491828820399347548094597669786126107928940054043377929918402,
                serialized.span()
            );
    }

    fn get_bck(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            573244657489650197093614909284741346972421912946440170517924192805324023489
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bck`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bck(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                573244657489650197093614909284741346972421912946440170517924192805324023489,
                serialized.span()
            );
    }

    fn get_bcb(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            801229738062111143144136047211246573999633895585510722122970041945048082387
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcb`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcb(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                801229738062111143144136047211246573999633895585510722122970041945048082387,
                serialized.span()
            );
    }

    fn get_bcq(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1442751505475707605270398768161750420762449777359565191205580678010518251793
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcq`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcq(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1442751505475707605270398768161750420762449777359565191205580678010518251793,
                serialized.span()
            );
    }

    fn get_side_to_move(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> Color {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            219186728921007360201595850127576360049656246336195436562291659965961844359
        );
        let field_value = core::serde::Serde::<Color>::deserialize(ref values);

        if core::option::OptionTrait::<Color>::is_none(@field_value) {
            panic!("Field `Board::side_to_move`: deserialization failed.");
        }

        core::option::OptionTrait::<Color>::unwrap(field_value)
    }

    fn set_side_to_move(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: Color) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                219186728921007360201595850127576360049656246336195436562291659965961844359,
                serialized.span()
            );
    }

    fn get_castling_rights(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            796422278502036855146051949378412010081878452086589689800032250389441779389
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::castling_rights`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_castling_rights(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                796422278502036855146051949378412010081878452086589689800032250389441779389,
                serialized.span()
            );
    }

    fn get_en_passant(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1607191152255112402547648874561628953695430356747805010487465139716100863533
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::en_passant`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_en_passant(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1607191152255112402547648874561628953695430356747805010487465139716100863533,
                serialized.span()
            );
    }

    fn get_halfmove_clock(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            1645912678769656887811129682265879366585241648517227076438762504371653455357
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::halfmove_clock`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_halfmove_clock(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1645912678769656887811129682265879366585241648517227076438762504371653455357,
                serialized.span()
            );
    }

    fn get_fullmove_number(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u16 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            911080323551738216805840859244168281848419522179145256528519470760599712350
        );
        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Board::fullmove_number`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_fullmove_number(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                911080323551738216805840859244168281848419522179145256528519470760599712350,
                serialized.span()
            );
    }

    fn get_last_move_time(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            449576191080313162908646466795983098315361149202238691633125442058044204149
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::last_move_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_last_move_time(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                449576191080313162908646466795983098315361149202238691633125442058044204149,
                serialized.span()
            );
    }

    fn get_last_move_integer(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            BoardEntity
        >::get_member(
            world,
            entity_id,
            425069929092323778433013422746164427852026833574957853456062719464171507025
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::last_move_integer`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_last_move_integer(self: @BoardEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                425069929092323778433013422746164427852026833574957853456062719464171507025,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl BoardStoreImpl of BoardStore {
    fn entity_id_from_keys(game_id: u128) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> Board {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Board>::deserialize(ref serialized);

        if core::option::OptionTrait::<Board>::is_none(@entity) {
            panic!(
                "Model `Board`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Board>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, game_id: u128) -> Board {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        dojo::model::Model::<Board>::get(world, serialized.span())
    }


    fn get_whites(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1705747694706323992214073110905003089127935460542149574887662201533726654496
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::whites`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_whites(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1705747694706323992214073110905003089127935460542149574887662201533726654496,
                serialized.span()
            );
    }

    fn get_blacks(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1257392403772608673631340426028594634371267472295708634309463492722226221310
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::blacks`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_blacks(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1257392403772608673631340426028594634371267472295708634309463492722226221310,
                serialized.span()
            );
    }

    fn get_pawns(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            100445355683423868029133084390108563423105841002474524988821046859423425387
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::pawns`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_pawns(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                100445355683423868029133084390108563423105841002474524988821046859423425387,
                serialized.span()
            );
    }

    fn get_rooks(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1309926837780207986270435218142762630800874618540521825033981166840758962756
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::rooks`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_rooks(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1309926837780207986270435218142762630800874618540521825033981166840758962756,
                serialized.span()
            );
    }

    fn get_knights(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            134188014602922373510402597182397164176587452352746481865596514775793337412
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::knights`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_knights(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                134188014602922373510402597182397164176587452352746481865596514775793337412,
                serialized.span()
            );
    }

    fn get_bishops(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            876986601864730550519389551774764061812796375965386567855544310760654525278
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::bishops`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_bishops(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                876986601864730550519389551774764061812796375965386567855544310760654525278,
                serialized.span()
            );
    }

    fn get_queens(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1767614546545229912599907953021793784596741962193331625852449073201322421033
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::queens`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_queens(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1767614546545229912599907953021793784596741962193331625852449073201322421033,
                serialized.span()
            );
    }

    fn get_kings(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1444815445559697790654470597664940970294153169701687558989190207649098248342
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::kings`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_kings(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1444815445559697790654470597664940970294153169701687558989190207649098248342,
                serialized.span()
            );
    }

    fn get_wcp(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1570679752520069770416622487903527459221732758604720482230447678406531618628
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcp`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcp(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1570679752520069770416622487903527459221732758604720482230447678406531618628,
                serialized.span()
            );
    }

    fn get_wcr(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            420810686662385673693121670188346434350575823793418534591370378522206067220
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcr`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcr(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                420810686662385673693121670188346434350575823793418534591370378522206067220,
                serialized.span()
            );
    }

    fn get_wck(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1681133480864355967291797619808592261598395339595244218543873940592851677063
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wck`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wck(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1681133480864355967291797619808592261598395339595244218543873940592851677063,
                serialized.span()
            );
    }

    fn get_wcb(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            730023975432539360839218489316411865773448791798759994637818003564454615426
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcb`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcb(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                730023975432539360839218489316411865773448791798759994637818003564454615426,
                serialized.span()
            );
    }

    fn get_wcq(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1513494961604514621453896480852178111543090692384935660895844555065379157179
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::wcq`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_wcq(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1513494961604514621453896480852178111543090692384935660895844555065379157179,
                serialized.span()
            );
    }

    fn get_bcp(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            122552401468341525665204066950724674156166866093002278590527811377217398673
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcp`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcp(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                122552401468341525665204066950724674156166866093002278590527811377217398673,
                serialized.span()
            );
    }

    fn get_bcr(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            221545091880640491828820399347548094597669786126107928940054043377929918402
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcr`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcr(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                221545091880640491828820399347548094597669786126107928940054043377929918402,
                serialized.span()
            );
    }

    fn get_bck(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            573244657489650197093614909284741346972421912946440170517924192805324023489
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bck`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bck(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                573244657489650197093614909284741346972421912946440170517924192805324023489,
                serialized.span()
            );
    }

    fn get_bcb(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            801229738062111143144136047211246573999633895585510722122970041945048082387
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcb`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcb(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                801229738062111143144136047211246573999633895585510722122970041945048082387,
                serialized.span()
            );
    }

    fn get_bcq(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1442751505475707605270398768161750420762449777359565191205580678010518251793
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::bcq`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_bcq(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1442751505475707605270398768161750420762449777359565191205580678010518251793,
                serialized.span()
            );
    }

    fn get_side_to_move(world: dojo::world::IWorldDispatcher, game_id: u128) -> Color {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            219186728921007360201595850127576360049656246336195436562291659965961844359
        );

        let field_value = core::serde::Serde::<Color>::deserialize(ref values);

        if core::option::OptionTrait::<Color>::is_none(@field_value) {
            panic!("Field `Board::side_to_move`: deserialization failed.");
        }

        core::option::OptionTrait::<Color>::unwrap(field_value)
    }

    fn set_side_to_move(self: @Board, world: dojo::world::IWorldDispatcher, value: Color) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                219186728921007360201595850127576360049656246336195436562291659965961844359,
                serialized.span()
            );
    }

    fn get_castling_rights(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            796422278502036855146051949378412010081878452086589689800032250389441779389
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::castling_rights`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_castling_rights(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                796422278502036855146051949378412010081878452086589689800032250389441779389,
                serialized.span()
            );
    }

    fn get_en_passant(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1607191152255112402547648874561628953695430356747805010487465139716100863533
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::en_passant`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_en_passant(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1607191152255112402547648874561628953695430356747805010487465139716100863533,
                serialized.span()
            );
    }

    fn get_halfmove_clock(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            1645912678769656887811129682265879366585241648517227076438762504371653455357
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Board::halfmove_clock`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_halfmove_clock(self: @Board, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1645912678769656887811129682265879366585241648517227076438762504371653455357,
                serialized.span()
            );
    }

    fn get_fullmove_number(world: dojo::world::IWorldDispatcher, game_id: u128) -> u16 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            911080323551738216805840859244168281848419522179145256528519470760599712350
        );

        let field_value = core::serde::Serde::<u16>::deserialize(ref values);

        if core::option::OptionTrait::<u16>::is_none(@field_value) {
            panic!("Field `Board::fullmove_number`: deserialization failed.");
        }

        core::option::OptionTrait::<u16>::unwrap(field_value)
    }

    fn set_fullmove_number(self: @Board, world: dojo::world::IWorldDispatcher, value: u16) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                911080323551738216805840859244168281848419522179145256528519470760599712350,
                serialized.span()
            );
    }

    fn get_last_move_time(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            449576191080313162908646466795983098315361149202238691633125442058044204149
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::last_move_time`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_last_move_time(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                449576191080313162908646466795983098315361149202238691633125442058044204149,
                serialized.span()
            );
    }

    fn get_last_move_integer(world: dojo::world::IWorldDispatcher, game_id: u128) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            Board
        >::get_member(
            world,
            serialized.span(),
            425069929092323778433013422746164427852026833574957853456062719464171507025
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Board::last_move_integer`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_last_move_integer(self: @Board, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                425069929092323778433013422746164427852026833574957853456062719464171507025,
                serialized.span()
            );
    }
}

pub impl BoardModelEntityImpl of dojo::model::ModelEntity<BoardEntity> {
    fn id(self: @BoardEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @BoardEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.whites, ref serialized);
        core::serde::Serde::serialize(self.blacks, ref serialized);
        core::serde::Serde::serialize(self.pawns, ref serialized);
        core::serde::Serde::serialize(self.rooks, ref serialized);
        core::serde::Serde::serialize(self.knights, ref serialized);
        core::serde::Serde::serialize(self.bishops, ref serialized);
        core::serde::Serde::serialize(self.queens, ref serialized);
        core::serde::Serde::serialize(self.kings, ref serialized);
        core::serde::Serde::serialize(self.wcp, ref serialized);
        core::serde::Serde::serialize(self.wcr, ref serialized);
        core::serde::Serde::serialize(self.wck, ref serialized);
        core::serde::Serde::serialize(self.wcb, ref serialized);
        core::serde::Serde::serialize(self.wcq, ref serialized);
        core::serde::Serde::serialize(self.bcp, ref serialized);
        core::serde::Serde::serialize(self.bcr, ref serialized);
        core::serde::Serde::serialize(self.bck, ref serialized);
        core::serde::Serde::serialize(self.bcb, ref serialized);
        core::serde::Serde::serialize(self.bcq, ref serialized);
        core::serde::Serde::serialize(self.side_to_move, ref serialized);
        core::serde::Serde::serialize(self.castling_rights, ref serialized);
        core::serde::Serde::serialize(self.en_passant, ref serialized);
        core::serde::Serde::serialize(self.halfmove_clock, ref serialized);
        core::serde::Serde::serialize(self.fullmove_number, ref serialized);
        core::serde::Serde::serialize(self.last_move_time, ref serialized);
        core::serde::Serde::serialize(self.last_move_integer, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> BoardEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<BoardEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<BoardEntity>::is_none(@entity_values) {
            panic!("ModelEntity `BoardEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<BoardEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> BoardEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<Board>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<Board>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @BoardEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<Board>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Board>::layout()
        );
    }

    fn delete(self: @BoardEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<Board>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Board>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Board>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<Board>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @BoardEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Board>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<Board>::selector(),
                    dojo::model::ModelIndex::MemberId((self.id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }
}

pub impl BoardModelImpl of dojo::model::Model<Board> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> Board {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        BoardStore::from_values(ref _keys, ref values)
    }

    fn set(self: @Board, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @Board, world: dojo::world::IWorldDispatcher) {
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
        self: @Board,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>
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
        "Board"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "rl_chess"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "rl_chess-Board"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        1265839794934304056984559014517714874314244553581374505478628017562967726840
    }

    #[inline(always)]
    fn instance_selector(self: @Board) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        888556790185447523786121241363668034227757394818884718147588309473258184627
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        521391545587964864438649656535115737286558186421403201930682034711360884972
    }

    #[inline(always)]
    fn entity_id(self: @Board) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @Board) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.game_id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Board) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.whites, ref serialized);
        core::serde::Serde::serialize(self.blacks, ref serialized);
        core::serde::Serde::serialize(self.pawns, ref serialized);
        core::serde::Serde::serialize(self.rooks, ref serialized);
        core::serde::Serde::serialize(self.knights, ref serialized);
        core::serde::Serde::serialize(self.bishops, ref serialized);
        core::serde::Serde::serialize(self.queens, ref serialized);
        core::serde::Serde::serialize(self.kings, ref serialized);
        core::serde::Serde::serialize(self.wcp, ref serialized);
        core::serde::Serde::serialize(self.wcr, ref serialized);
        core::serde::Serde::serialize(self.wck, ref serialized);
        core::serde::Serde::serialize(self.wcb, ref serialized);
        core::serde::Serde::serialize(self.wcq, ref serialized);
        core::serde::Serde::serialize(self.bcp, ref serialized);
        core::serde::Serde::serialize(self.bcr, ref serialized);
        core::serde::Serde::serialize(self.bck, ref serialized);
        core::serde::Serde::serialize(self.bcb, ref serialized);
        core::serde::Serde::serialize(self.bcq, ref serialized);
        core::serde::Serde::serialize(self.side_to_move, ref serialized);
        core::serde::Serde::serialize(self.castling_rights, ref serialized);
        core::serde::Serde::serialize(self.en_passant, ref serialized);
        core::serde::Serde::serialize(self.halfmove_clock, ref serialized);
        core::serde::Serde::serialize(self.fullmove_number, ref serialized);
        core::serde::Serde::serialize(self.last_move_time, ref serialized);
        core::serde::Serde::serialize(self.last_move_integer, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<Board>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Board) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[starknet::interface]
pub trait Iboard<T> {
    fn ensure_abi(self: @T, model: Board);
}

#[starknet::contract]
pub mod board {
    use super::Board;
    use super::Iboard;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Board>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Board>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Board>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Board>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Board>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Board>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Board>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<Board>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Board>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<Board>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<Board>::ty()
        }
    }

    #[abi(embed_v0)]
    impl boardImpl of Iboard<ContractState> {
        fn ensure_abi(self: @ContractState, model: Board) {}
    }
}
