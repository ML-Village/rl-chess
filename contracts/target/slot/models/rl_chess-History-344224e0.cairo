impl HistoryIntrospect<> of dojo::model::introspect::Introspect<History<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::None
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 701868258393739297020501573873153377996008154464531908573106670403438484961,
                    layout: dojo::model::introspect::Introspect::<ByteArray>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1234691527377236107127492161827171346418243693150658777772564910193910632372,
                    layout: dojo::model::introspect::Introspect::<Array<felt252>>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1373242766678245225105261056369747431098160712994099637379440182760270939242,
                    layout: dojo::model::introspect::Introspect::<ByteArray>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1072743538573475219273297707049210018001715515866663365612851796974667876773,
                    layout: dojo::model::introspect::Introspect::<ByteArray>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1299397479821445608513566113258255902232636188550940046479871290186477665835,
                    layout: dojo::model::introspect::Introspect::<ByteArray>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 11638631457543901549464375731617681873047796369191466340183956293736981152,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 836149510480670879762425929492908840399331211298303588285160130940024863909,
                    layout: dojo::model::introspect::Introspect::<u8>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'History',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'game_id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<u128>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'fen',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Ty::ByteArray
                    },
                    dojo::model::introspect::Member {
                        name: 'fen_hash_hist',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Ty::Array(
                            array![dojo::model::introspect::Introspect::<felt252>::ty()].span()
                        )
                    },
                    dojo::model::introspect::Member {
                        name: 'fen_history',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Ty::ByteArray
                    },
                    dojo::model::introspect::Member {
                        name: 'move_history_string',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Ty::ByteArray
                    },
                    dojo::model::introspect::Member {
                        name: 'move_history_integer',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Ty::ByteArray
                    },
                    dojo::model::introspect::Member {
                        name: 'last_move_from',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'last_move_to',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct HistoryEntity {
    __id: felt252, // private field
    pub fen: ByteArray,
    pub fen_hash_hist: Array<felt252>,
    pub fen_history: ByteArray,
    pub move_history_string: ByteArray,
    pub move_history_integer: ByteArray,
    pub last_move_from: u8,
    pub last_move_to: u8,
}

#[generate_trait]
pub impl HistoryEntityStoreImpl of HistoryEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> HistoryEntity {
        HistoryModelEntityImpl::get(world, entity_id)
    }


    fn get_fen(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> ByteArray {
        let mut values = dojo::model::ModelEntity::<
            HistoryEntity
        >::get_member(
            world,
            entity_id,
            701868258393739297020501573873153377996008154464531908573106670403438484961
        );
        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::fen`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_fen(self: @HistoryEntity, world: dojo::world::IWorldDispatcher, value: ByteArray) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                701868258393739297020501573873153377996008154464531908573106670403438484961,
                serialized.span()
            );
    }

    fn get_fen_hash_hist(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> Array<felt252> {
        let mut values = dojo::model::ModelEntity::<
            HistoryEntity
        >::get_member(
            world,
            entity_id,
            1234691527377236107127492161827171346418243693150658777772564910193910632372
        );
        let field_value = core::serde::Serde::<Array<felt252>>::deserialize(ref values);

        if core::option::OptionTrait::<Array<felt252>>::is_none(@field_value) {
            panic!("Field `History::fen_hash_hist`: deserialization failed.");
        }

        core::option::OptionTrait::<Array<felt252>>::unwrap(field_value)
    }

    fn set_fen_hash_hist(
        self: @HistoryEntity, world: dojo::world::IWorldDispatcher, value: Array<felt252>
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1234691527377236107127492161827171346418243693150658777772564910193910632372,
                serialized.span()
            );
    }

    fn get_fen_history(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> ByteArray {
        let mut values = dojo::model::ModelEntity::<
            HistoryEntity
        >::get_member(
            world,
            entity_id,
            1373242766678245225105261056369747431098160712994099637379440182760270939242
        );
        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::fen_history`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_fen_history(
        self: @HistoryEntity, world: dojo::world::IWorldDispatcher, value: ByteArray
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1373242766678245225105261056369747431098160712994099637379440182760270939242,
                serialized.span()
            );
    }

    fn get_move_history_string(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ByteArray {
        let mut values = dojo::model::ModelEntity::<
            HistoryEntity
        >::get_member(
            world,
            entity_id,
            1072743538573475219273297707049210018001715515866663365612851796974667876773
        );
        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::move_history_string`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_move_history_string(
        self: @HistoryEntity, world: dojo::world::IWorldDispatcher, value: ByteArray
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1072743538573475219273297707049210018001715515866663365612851796974667876773,
                serialized.span()
            );
    }

    fn get_move_history_integer(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ByteArray {
        let mut values = dojo::model::ModelEntity::<
            HistoryEntity
        >::get_member(
            world,
            entity_id,
            1299397479821445608513566113258255902232636188550940046479871290186477665835
        );
        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::move_history_integer`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_move_history_integer(
        self: @HistoryEntity, world: dojo::world::IWorldDispatcher, value: ByteArray
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1299397479821445608513566113258255902232636188550940046479871290186477665835,
                serialized.span()
            );
    }

    fn get_last_move_from(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            HistoryEntity
        >::get_member(
            world,
            entity_id,
            11638631457543901549464375731617681873047796369191466340183956293736981152
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `History::last_move_from`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_last_move_from(self: @HistoryEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                11638631457543901549464375731617681873047796369191466340183956293736981152,
                serialized.span()
            );
    }

    fn get_last_move_to(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> u8 {
        let mut values = dojo::model::ModelEntity::<
            HistoryEntity
        >::get_member(
            world,
            entity_id,
            836149510480670879762425929492908840399331211298303588285160130940024863909
        );
        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `History::last_move_to`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_last_move_to(self: @HistoryEntity, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                836149510480670879762425929492908840399331211298303588285160130940024863909,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl HistoryStoreImpl of HistoryStore {
    fn entity_id_from_keys(game_id: u128) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> History {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<History>::deserialize(ref serialized);

        if core::option::OptionTrait::<History>::is_none(@entity) {
            panic!(
                "Model `History`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<History>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, game_id: u128) -> History {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        dojo::model::Model::<History>::get(world, serialized.span())
    }


    fn get_fen(world: dojo::world::IWorldDispatcher, game_id: u128) -> ByteArray {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            History
        >::get_member(
            world,
            serialized.span(),
            701868258393739297020501573873153377996008154464531908573106670403438484961
        );

        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::fen`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_fen(self: @History, world: dojo::world::IWorldDispatcher, value: ByteArray) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                701868258393739297020501573873153377996008154464531908573106670403438484961,
                serialized.span()
            );
    }

    fn get_fen_hash_hist(world: dojo::world::IWorldDispatcher, game_id: u128) -> Array<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            History
        >::get_member(
            world,
            serialized.span(),
            1234691527377236107127492161827171346418243693150658777772564910193910632372
        );

        let field_value = core::serde::Serde::<Array<felt252>>::deserialize(ref values);

        if core::option::OptionTrait::<Array<felt252>>::is_none(@field_value) {
            panic!("Field `History::fen_hash_hist`: deserialization failed.");
        }

        core::option::OptionTrait::<Array<felt252>>::unwrap(field_value)
    }

    fn set_fen_hash_hist(
        self: @History, world: dojo::world::IWorldDispatcher, value: Array<felt252>
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1234691527377236107127492161827171346418243693150658777772564910193910632372,
                serialized.span()
            );
    }

    fn get_fen_history(world: dojo::world::IWorldDispatcher, game_id: u128) -> ByteArray {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            History
        >::get_member(
            world,
            serialized.span(),
            1373242766678245225105261056369747431098160712994099637379440182760270939242
        );

        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::fen_history`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_fen_history(self: @History, world: dojo::world::IWorldDispatcher, value: ByteArray) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1373242766678245225105261056369747431098160712994099637379440182760270939242,
                serialized.span()
            );
    }

    fn get_move_history_string(world: dojo::world::IWorldDispatcher, game_id: u128) -> ByteArray {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            History
        >::get_member(
            world,
            serialized.span(),
            1072743538573475219273297707049210018001715515866663365612851796974667876773
        );

        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::move_history_string`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_move_history_string(
        self: @History, world: dojo::world::IWorldDispatcher, value: ByteArray
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1072743538573475219273297707049210018001715515866663365612851796974667876773,
                serialized.span()
            );
    }

    fn get_move_history_integer(world: dojo::world::IWorldDispatcher, game_id: u128) -> ByteArray {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            History
        >::get_member(
            world,
            serialized.span(),
            1299397479821445608513566113258255902232636188550940046479871290186477665835
        );

        let field_value = core::serde::Serde::<ByteArray>::deserialize(ref values);

        if core::option::OptionTrait::<ByteArray>::is_none(@field_value) {
            panic!("Field `History::move_history_integer`: deserialization failed.");
        }

        core::option::OptionTrait::<ByteArray>::unwrap(field_value)
    }

    fn set_move_history_integer(
        self: @History, world: dojo::world::IWorldDispatcher, value: ByteArray
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1299397479821445608513566113258255902232636188550940046479871290186477665835,
                serialized.span()
            );
    }

    fn get_last_move_from(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            History
        >::get_member(
            world,
            serialized.span(),
            11638631457543901549464375731617681873047796369191466340183956293736981152
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `History::last_move_from`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_last_move_from(self: @History, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                11638631457543901549464375731617681873047796369191466340183956293736981152,
                serialized.span()
            );
    }

    fn get_last_move_to(world: dojo::world::IWorldDispatcher, game_id: u128) -> u8 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@game_id, ref serialized);

        let mut values = dojo::model::Model::<
            History
        >::get_member(
            world,
            serialized.span(),
            836149510480670879762425929492908840399331211298303588285160130940024863909
        );

        let field_value = core::serde::Serde::<u8>::deserialize(ref values);

        if core::option::OptionTrait::<u8>::is_none(@field_value) {
            panic!("Field `History::last_move_to`: deserialization failed.");
        }

        core::option::OptionTrait::<u8>::unwrap(field_value)
    }

    fn set_last_move_to(self: @History, world: dojo::world::IWorldDispatcher, value: u8) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                836149510480670879762425929492908840399331211298303588285160130940024863909,
                serialized.span()
            );
    }
}

pub impl HistoryModelEntityImpl of dojo::model::ModelEntity<HistoryEntity> {
    fn id(self: @HistoryEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @HistoryEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.fen, ref serialized);
        core::serde::Serde::serialize(self.fen_hash_hist, ref serialized);
        core::serde::Serde::serialize(self.fen_history, ref serialized);
        core::serde::Serde::serialize(self.move_history_string, ref serialized);
        core::serde::Serde::serialize(self.move_history_integer, ref serialized);
        core::serde::Serde::serialize(self.last_move_from, ref serialized);
        core::serde::Serde::serialize(self.last_move_to, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> HistoryEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<HistoryEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<HistoryEntity>::is_none(@entity_values) {
            panic!("ModelEntity `HistoryEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<HistoryEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> HistoryEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<History>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<History>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update(self: @HistoryEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<History>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<History>::layout()
        );
    }

    fn delete(self: @HistoryEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<History>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<History>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<History>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<History>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @HistoryEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<History>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<History>::selector(),
                    dojo::model::ModelIndex::MemberId((self.id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }
}

pub impl HistoryModelImpl of dojo::model::Model<History> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> History {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        HistoryStore::from_values(ref _keys, ref values)
    }

    fn set(self: @History, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete(self: @History, world: dojo::world::IWorldDispatcher) {
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
        self: @History,
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
        "History"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "rl_chess"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "rl_chess-History"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        1477320908446886035508255371566378777675603294893082513704668448647780757166
    }

    #[inline(always)]
    fn instance_selector(self: @History) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        1142048918269180692833134072903522117015024054550972923317540338010435652781
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        521391545587964864438649656535115737286558186421403201930682034711360884972
    }

    #[inline(always)]
    fn entity_id(self: @History) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @History) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.game_id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @History) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.fen, ref serialized);
        core::serde::Serde::serialize(self.fen_hash_hist, ref serialized);
        core::serde::Serde::serialize(self.fen_history, ref serialized);
        core::serde::Serde::serialize(self.move_history_string, ref serialized);
        core::serde::Serde::serialize(self.move_history_integer, ref serialized);
        core::serde::Serde::serialize(self.last_move_from, ref serialized);
        core::serde::Serde::serialize(self.last_move_to, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<History>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @History) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[starknet::interface]
pub trait Ihistory<T> {
    fn ensure_abi(self: @T, model: History);
}

#[starknet::contract]
pub mod history {
    use super::History;
    use super::Ihistory;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<History>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<History>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<History>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<History>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<History>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<History>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<History>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<History>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<History>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<History>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<History>::ty()
        }
    }

    #[abi(embed_v0)]
    impl historyImpl of Ihistory<ContractState> {
        fn ensure_abi(self: @ContractState, model: History) {}
    }
}
