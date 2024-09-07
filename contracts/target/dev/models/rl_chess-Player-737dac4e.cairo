impl PlayerIntrospect<> of dojo::model::introspect::Introspect<Player<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        let sizes: Array<Option<usize>> = array![
            dojo::model::introspect::Introspect::<ProfilePicType>::size(), Option::Some(3)
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
                    selector: 1528802474226268325865027367859591458315299653151958663884057507666229546336,
                    layout: dojo::model::introspect::Introspect::<felt252>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 877224838980596231148988320776089951584361707847958298236611351152972542071,
                    layout: dojo::model::introspect::Introspect::<ProfilePicType>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 377873905795975839677646874633806590921301036337094729468253709378233133597,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1242883636335185042648196101482844477055185136100498177742807244790485718414,
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
                name: 'Player',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'address',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'name',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'profile_pic_type',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<ProfilePicType>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'profile_pic_uri',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'timestamp',
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
pub struct PlayerEntity {
    __id: felt252, // private field
    pub name: felt252,
    pub profile_pic_type: ProfilePicType,
    pub profile_pic_uri: u64,
    pub timestamp: u64,
}

#[generate_trait]
pub impl PlayerEntityStoreImpl of PlayerEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> PlayerEntity {
        PlayerModelEntityImpl::get(world, entity_id)
    }


    fn get_name(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> felt252 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            1528802474226268325865027367859591458315299653151958663884057507666229546336
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Player::name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_name(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1528802474226268325865027367859591458315299653151958663884057507666229546336,
                serialized.span()
            );
    }

    fn get_profile_pic_type(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ProfilePicType {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            877224838980596231148988320776089951584361707847958298236611351152972542071
        );
        let field_value = core::serde::Serde::<ProfilePicType>::deserialize(ref values);

        if core::option::OptionTrait::<ProfilePicType>::is_none(@field_value) {
            panic!("Field `Player::profile_pic_type`: deserialization failed.");
        }

        core::option::OptionTrait::<ProfilePicType>::unwrap(field_value)
    }

    fn set_profile_pic_type(
        self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: ProfilePicType
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                877224838980596231148988320776089951584361707847958298236611351152972542071,
                serialized.span()
            );
    }

    fn get_profile_pic_uri(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            377873905795975839677646874633806590921301036337094729468253709378233133597
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Player::profile_pic_uri`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_profile_pic_uri(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                377873905795975839677646874633806590921301036337094729468253709378233133597,
                serialized.span()
            );
    }

    fn get_timestamp(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            PlayerEntity
        >::get_member(
            world,
            entity_id,
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Player::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @PlayerEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1242883636335185042648196101482844477055185136100498177742807244790485718414,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl PlayerStoreImpl of PlayerStore {
    fn entity_id_from_keys(address: ContractAddress) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@address, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> Player {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Player>::deserialize(ref serialized);

        if core::option::OptionTrait::<Player>::is_none(@entity) {
            panic!(
                "Model `Player`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Player>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, address: ContractAddress) -> Player {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@address, ref serialized);

        dojo::model::Model::<Player>::get(world, serialized.span())
    }


    fn get_name(world: dojo::world::IWorldDispatcher, address: ContractAddress) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@address, ref serialized);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            1528802474226268325865027367859591458315299653151958663884057507666229546336
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Player::name`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_name(self: @Player, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1528802474226268325865027367859591458315299653151958663884057507666229546336,
                serialized.span()
            );
    }

    fn get_profile_pic_type(
        world: dojo::world::IWorldDispatcher, address: ContractAddress
    ) -> ProfilePicType {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@address, ref serialized);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            877224838980596231148988320776089951584361707847958298236611351152972542071
        );

        let field_value = core::serde::Serde::<ProfilePicType>::deserialize(ref values);

        if core::option::OptionTrait::<ProfilePicType>::is_none(@field_value) {
            panic!("Field `Player::profile_pic_type`: deserialization failed.");
        }

        core::option::OptionTrait::<ProfilePicType>::unwrap(field_value)
    }

    fn set_profile_pic_type(
        self: @Player, world: dojo::world::IWorldDispatcher, value: ProfilePicType
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                877224838980596231148988320776089951584361707847958298236611351152972542071,
                serialized.span()
            );
    }

    fn get_profile_pic_uri(world: dojo::world::IWorldDispatcher, address: ContractAddress) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@address, ref serialized);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            377873905795975839677646874633806590921301036337094729468253709378233133597
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Player::profile_pic_uri`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_profile_pic_uri(self: @Player, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                377873905795975839677646874633806590921301036337094729468253709378233133597,
                serialized.span()
            );
    }

    fn get_timestamp(world: dojo::world::IWorldDispatcher, address: ContractAddress) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@address, ref serialized);

        let mut values = dojo::model::Model::<
            Player
        >::get_member(
            world,
            serialized.span(),
            1242883636335185042648196101482844477055185136100498177742807244790485718414
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Player::timestamp`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_timestamp(self: @Player, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1242883636335185042648196101482844477055185136100498177742807244790485718414,
                serialized.span()
            );
    }
}

pub impl PlayerModelEntityImpl of dojo::model::ModelEntity<PlayerEntity> {
    fn id(self: @PlayerEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @PlayerEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.name);
        core::serde::Serde::serialize(self.profile_pic_type, ref serialized);
        core::serde::Serde::serialize(self.profile_pic_uri, ref serialized);
        core::serde::Serde::serialize(self.timestamp, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> PlayerEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<PlayerEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<PlayerEntity>::is_none(@entity_values) {
            panic!("ModelEntity `PlayerEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<PlayerEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> PlayerEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<Player>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @PlayerEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Player>::layout()
        );
    }

    fn delete(self: @PlayerEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<Player>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Player>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Player>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<Player>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @PlayerEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Player>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<Player>::selector(),
                    dojo::model::ModelIndex::MemberId((self.id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }
}

pub impl PlayerModelImpl of dojo::model::Model<Player> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> Player {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        PlayerStore::from_values(ref _keys, ref values)
    }

    fn set(self: @Player, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @Player, world: dojo::world::IWorldDispatcher) {
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
        self: @Player,
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
        "Player"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "rl_chess"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "rl_chess-Player"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        3264876417927824193716283731524985049147382800930585440715283934749610249264
    }

    #[inline(always)]
    fn instance_selector(self: @Player) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        1073075359926275415180704315933677548333097210683379121732618306925003101845
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        521391545587964864438649656535115737286558186421403201930682034711360884972
    }

    #[inline(always)]
    fn entity_id(self: @Player) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @Player) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.address, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Player) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.name);
        core::serde::Serde::serialize(self.profile_pic_type, ref serialized);
        core::serde::Serde::serialize(self.profile_pic_uri, ref serialized);
        core::serde::Serde::serialize(self.timestamp, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<Player>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Player) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[starknet::interface]
pub trait Iplayer<T> {
    fn ensure_abi(self: @T, model: Player);
}

#[starknet::contract]
pub mod player {
    use super::Player;
    use super::Iplayer;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Player>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Player>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Player>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Player>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Player>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Player>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Player>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<Player>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Player>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<Player>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<Player>::ty()
        }
    }

    #[abi(embed_v0)]
    impl playerImpl of Iplayer<ContractState> {
        fn ensure_abi(self: @ContractState, model: Player) {}
    }
}
