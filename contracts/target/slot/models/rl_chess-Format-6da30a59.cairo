impl FormatIntrospect<> of dojo::model::introspect::Introspect<Format<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(6)
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 718859826124811249370079768522367444425216844897376661344757648534845963150,
                    layout: dojo::model::introspect::Introspect::<felt252>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1529236133159767039052957491254871913206389845876070690375220280949899140072,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1333259007159691585195290311740703289806221750468006049291949150271668866265,
                    layout: dojo::model::introspect::Introspect::<u64>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 239137283881597115981829662924893930895820307988789457820803769849782557933,
                    layout: dojo::model::introspect::Introspect::<felt252>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 216030643445273762074482936742625134427639679021380938148798651889117677069,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 754783350398011671681498052655346759050446992605832132962920862812729555339,
                    layout: dojo::model::introspect::Introspect::<bool>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'Format',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'format_id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<u16>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'description',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'turn_expiry',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'total_time_per_side',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u64>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'total_time_string',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'increment',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'available',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<bool>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct FormatEntity {
    __id: felt252, // private field
    pub description: felt252,
    pub turn_expiry: u64,
    pub total_time_per_side: u64,
    pub total_time_string: felt252,
    pub increment: u8,
    pub available: bool,
}

#[generate_trait]
pub impl FormatEntityStoreImpl of FormatEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> FormatEntity {
        FormatModelEntityImpl::get(world, entity_id)
    }


    fn get_description(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> felt252 {
        let mut values = dojo::model::ModelEntity::<
            FormatEntity
        >::get_member(
            world,
            entity_id,
            718859826124811249370079768522367444425216844897376661344757648534845963150
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Format::description`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_description(self: @FormatEntity, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                718859826124811249370079768522367444425216844897376661344757648534845963150,
                serialized.span()
            );
    }

    fn get_turn_expiry(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            FormatEntity
        >::get_member(
            world,
            entity_id,
            1529236133159767039052957491254871913206389845876070690375220280949899140072
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Format::turn_expiry`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_turn_expiry(self: @FormatEntity, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1529236133159767039052957491254871913206389845876070690375220280949899140072,
                serialized.span()
            );
    }

    fn get_total_time_per_side(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u64 {
        let mut values = dojo::model::ModelEntity::<
            FormatEntity
        >::get_member(
            world,
            entity_id,
            1333259007159691585195290311740703289806221750468006049291949150271668866265
        );
        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Format::total_time_per_side`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_total_time_per_side(
        self: @FormatEntity, world: dojo::world::IWorldDispatcher, value: u64
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1333259007159691585195290311740703289806221750468006049291949150271668866265,
                serialized.span()
            );
    }

    fn get_total_time_string(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> felt252 {
        let mut values = dojo::model::ModelEntity::<
            FormatEntity
        >::get_member(
            world,
            entity_id,
            239137283881597115981829662924893930895820307988789457820803769849782557933
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Format::total_time_string`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_total_time_string(
        self: @FormatEntity, world: dojo::world::IWorldDispatcher, value: felt252
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                239137283881597115981829662924893930895820307988789457820803769849782557933,
                serialized.span()
            );
    }

    fn get_increment(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            FormatEntity
        >::get_member(
            world,
            entity_id,
            216030643445273762074482936742625134427639679021380938148798651889117677069
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Format::increment`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_increment(self: @FormatEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                216030643445273762074482936742625134427639679021380938148798651889117677069,
                serialized.span()
            );
    }

    fn get_available(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> bool {
        let mut values = dojo::model::ModelEntity::<
            FormatEntity
        >::get_member(
            world,
            entity_id,
            754783350398011671681498052655346759050446992605832132962920862812729555339
        );
        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `Format::available`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_available(self: @FormatEntity, world: dojo::world::IWorldDispatcher, value: bool) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                754783350398011671681498052655346759050446992605832132962920862812729555339,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl FormatStoreImpl of FormatStore {
    fn entity_id_from_keys(format_id: u16) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> Format {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Format>::deserialize(ref serialized);

        if core::option::OptionTrait::<Format>::is_none(@entity) {
            panic!(
                "Model `Format`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Format>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, format_id: u16) -> Format {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        dojo::model::Model::<Format>::get(world, serialized.span())
    }


    fn get_description(world: dojo::world::IWorldDispatcher, format_id: u16) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        let mut values = dojo::model::Model::<
            Format
        >::get_member(
            world,
            serialized.span(),
            718859826124811249370079768522367444425216844897376661344757648534845963150
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Format::description`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_description(self: @Format, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                718859826124811249370079768522367444425216844897376661344757648534845963150,
                serialized.span()
            );
    }

    fn get_turn_expiry(world: dojo::world::IWorldDispatcher, format_id: u16) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        let mut values = dojo::model::Model::<
            Format
        >::get_member(
            world,
            serialized.span(),
            1529236133159767039052957491254871913206389845876070690375220280949899140072
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Format::turn_expiry`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_turn_expiry(self: @Format, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1529236133159767039052957491254871913206389845876070690375220280949899140072,
                serialized.span()
            );
    }

    fn get_total_time_per_side(world: dojo::world::IWorldDispatcher, format_id: u16) -> u64 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        let mut values = dojo::model::Model::<
            Format
        >::get_member(
            world,
            serialized.span(),
            1333259007159691585195290311740703289806221750468006049291949150271668866265
        );

        let field_value = core::serde::Serde::<u64>::deserialize(ref values);

        if core::option::OptionTrait::<u64>::is_none(@field_value) {
            panic!("Field `Format::total_time_per_side`: deserialization failed.");
        }

        core::option::OptionTrait::<u64>::unwrap(field_value)
    }

    fn set_total_time_per_side(self: @Format, world: dojo::world::IWorldDispatcher, value: u64) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1333259007159691585195290311740703289806221750468006049291949150271668866265,
                serialized.span()
            );
    }

    fn get_total_time_string(world: dojo::world::IWorldDispatcher, format_id: u16) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        let mut values = dojo::model::Model::<
            Format
        >::get_member(
            world,
            serialized.span(),
            239137283881597115981829662924893930895820307988789457820803769849782557933
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Format::total_time_string`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_total_time_string(self: @Format, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                239137283881597115981829662924893930895820307988789457820803769849782557933,
                serialized.span()
            );
    }

    fn get_increment(world: dojo::world::IWorldDispatcher, format_id: u16) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        let mut values = dojo::model::Model::<
            Format
        >::get_member(
            world,
            serialized.span(),
            216030643445273762074482936742625134427639679021380938148798651889117677069
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `Format::increment`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_increment(self: @Format, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                216030643445273762074482936742625134427639679021380938148798651889117677069,
                serialized.span()
            );
    }

    fn get_available(world: dojo::world::IWorldDispatcher, format_id: u16) -> bool {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@format_id, ref serialized);

        let mut values = dojo::model::Model::<
            Format
        >::get_member(
            world,
            serialized.span(),
            754783350398011671681498052655346759050446992605832132962920862812729555339
        );

        let field_value = core::serde::Serde::<bool>::deserialize(ref values);

        if core::option::OptionTrait::<bool>::is_none(@field_value) {
            panic!("Field `Format::available`: deserialization failed.");
        }

        core::option::OptionTrait::<bool>::unwrap(field_value)
    }

    fn set_available(self: @Format, world: dojo::world::IWorldDispatcher, value: bool) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                754783350398011671681498052655346759050446992605832132962920862812729555339,
                serialized.span()
            );
    }
}

pub impl FormatModelEntityImpl of dojo::model::ModelEntity<FormatEntity> {
    fn id(self: @FormatEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @FormatEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.description);
        core::serde::Serde::serialize(self.turn_expiry, ref serialized);
        core::serde::Serde::serialize(self.total_time_per_side, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.total_time_string);
        core::serde::Serde::serialize(self.increment, ref serialized);
        core::serde::Serde::serialize(self.available, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> FormatEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<FormatEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<FormatEntity>::is_none(@entity_values) {
            panic!("ModelEntity `FormatEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<FormatEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> FormatEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<Format>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<Format>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @FormatEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<Format>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Format>::layout()
        );
    }

    fn delete(self: @FormatEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<Format>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Format>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Format>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<Format>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @FormatEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Format>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<Format>::selector(),
                    dojo::model::ModelIndex::MemberId((self.id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }
}

pub impl FormatModelImpl of dojo::model::Model<Format> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> Format {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        FormatStore::from_values(ref _keys, ref values)
    }

    fn set(self: @Format, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @Format, world: dojo::world::IWorldDispatcher) {
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
        self: @Format,
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
        "Format"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "rl_chess"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "rl_chess-Format"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        3099385500419154202310861455016637332890204890221417127173115355032841699535
    }

    #[inline(always)]
    fn instance_selector(self: @Format) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        202870847240411381386937032441453602914206899976382923341489205117866204811
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        521391545587964864438649656535115737286558186421403201930682034711360884972
    }

    #[inline(always)]
    fn entity_id(self: @Format) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @Format) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.format_id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Format) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::array::ArrayTrait::append(ref serialized, *self.description);
        core::serde::Serde::serialize(self.turn_expiry, ref serialized);
        core::serde::Serde::serialize(self.total_time_per_side, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.total_time_string);
        core::serde::Serde::serialize(self.increment, ref serialized);
        core::serde::Serde::serialize(self.available, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<Format>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Format) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[starknet::interface]
pub trait Iformat<T> {
    fn ensure_abi(self: @T, model: Format);
}

#[starknet::contract]
pub mod format {
    use super::Format;
    use super::Iformat;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Format>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Format>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Format>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Format>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Format>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Format>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Format>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<Format>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Format>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<Format>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<Format>::ty()
        }
    }

    #[abi(embed_v0)]
    impl formatImpl of Iformat<ContractState> {
        fn ensure_abi(self: @ContractState, model: Format) {}
    }
}
