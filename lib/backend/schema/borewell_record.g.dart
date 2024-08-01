// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borewell_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BorewellRecord> _$borewellRecordSerializer =
    new _$BorewellRecordSerializer();

class _$BorewellRecordSerializer
    implements StructuredSerializer<BorewellRecord> {
  @override
  final Iterable<Type> types = const [BorewellRecord, _$BorewellRecord];
  @override
  final String wireName = 'BorewellRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, BorewellRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.borewellName;
    if (value != null) {
      result
        ..add('BorewellName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.borewellKey;
    if (value != null) {
      result
        ..add('BorewellKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.height;
    if (value != null) {
      result
        ..add('Height')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BorewellRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BorewellRecordBuilder();
    final iterator = serialized.iterator;

    while (iterator.moveNext()) {
      final key = iterator.current! as String;

      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'BorewellName':
          result.borewellName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;

        case 'BorewellKey':
          result.borewellKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;

        case 'Height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;

        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$BorewellRecord extends BorewellRecord {
  @override
  final String? borewellName;

  @override
  final String? borewellKey;

  @override
  final String? height;

  @override
  final DocumentReference<Object?>? ffRef;

  factory _$BorewellRecord([void Function(BorewellRecordBuilder)? updates]) =>
      (new BorewellRecordBuilder()..update(updates))._build();

  _$BorewellRecord._(
      {this.borewellName, this.borewellKey, this.height, this.ffRef})
      : super._();

  @override
  BorewellRecord rebuild(void Function(BorewellRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BorewellRecordBuilder toBuilder() =>
      new BorewellRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BorewellRecord &&
        borewellName == other.borewellName &&
        borewellKey == other.borewellKey &&
        height == other.height &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, borewellName.hashCode), borewellKey.hashCode),
            height.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BorewellRecord')
          ..add('borewellName', borewellName)
          ..add('borewellKey', borewellKey)
          ..add('height', height)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class BorewellRecordBuilder
    implements Builder<BorewellRecord, BorewellRecordBuilder> {
  _$BorewellRecord? _$v;

  String? _borewellName;
  String? get borewellName => _$this._borewellName;
  set borewellName(String? borewellName) => _$this._borewellName = borewellName;

  String? _borewellKey;
  String? get borewellKey => _$this._borewellKey;
  set borewellKey(String? borewellKey) => _$this._borewellKey = borewellKey;

  String? _height;
  String? get height => _$this._height;
  set height(String? height) => _$this._height = height;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  BorewellRecordBuilder() {
    BorewellRecord._initializeBuilder(this);
  }

  BorewellRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _borewellName = $v.borewellName;
      _borewellKey = $v.borewellKey;

      _height = $v.height;

      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BorewellRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BorewellRecord;
  }

  @override
  void update(void Function(BorewellRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BorewellRecord build() => _build();

  _$BorewellRecord _build() {
    final _$result = _$v ??
        new _$BorewellRecord._(
            borewellName: borewellName,
            borewellKey: borewellKey,
            height: height,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
