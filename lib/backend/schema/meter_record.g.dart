// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MeterRecord> _$meterRecordSerializer = new _$MeterRecordSerializer();

class _$MeterRecordSerializer implements StructuredSerializer<MeterRecord> {
  @override
  final Iterable<Type> types = const [MeterRecord, _$MeterRecord];
  @override
  final String wireName = 'MeterRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, MeterRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.meterName;
    if (value != null) {
      result
        ..add('MeterName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.meterKey;
    if (value != null) {
      result
        ..add('MeterKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  MeterRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MeterRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'MeterName':
          result.meterName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'MeterKey':
          result.meterKey = serializers.deserialize(value,
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

class _$MeterRecord extends MeterRecord {
  @override
  final String? meterName;
  @override
  final String? meterKey;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$MeterRecord([void Function(MeterRecordBuilder)? updates]) =>
      (new MeterRecordBuilder()..update(updates))._build();

  _$MeterRecord._({this.meterName, this.meterKey, this.ffRef}) : super._();

  @override
  MeterRecord rebuild(void Function(MeterRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MeterRecordBuilder toBuilder() => new MeterRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MeterRecord &&
        meterName == other.meterName &&
        meterKey == other.meterKey &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, meterName.hashCode), meterKey.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MeterRecord')
          ..add('meterName', meterName)
          ..add('meterKey', meterKey)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class MeterRecordBuilder implements Builder<MeterRecord, MeterRecordBuilder> {
  _$MeterRecord? _$v;

  String? _meterName;
  String? get meterName => _$this._meterName;
  set meterName(String? meterName) => _$this._meterName = meterName;

  String? _meterKey;
  String? get meterKey => _$this._meterKey;
  set meterKey(String? meterKey) => _$this._meterKey = meterKey;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  MeterRecordBuilder() {
    MeterRecord._initializeBuilder(this);
  }

  MeterRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _meterName = $v.meterName;
      _meterKey = $v.meterKey;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MeterRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MeterRecord;
  }

  @override
  void update(void Function(MeterRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MeterRecord build() => _build();

  _$MeterRecord _build() {
    final _$result = _$v ??
        new _$MeterRecord._(
            meterName: meterName, meterKey: meterKey, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas