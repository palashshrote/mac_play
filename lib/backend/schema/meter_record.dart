import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'meter_record.g.dart';

abstract class MeterRecord implements Built<MeterRecord, MeterRecordBuilder> {
  static Serializer<MeterRecord> get serializer => _$meterRecordSerializer;

  @BuiltValueField(wireName: 'MeterName')
  String? get meterName;

  @BuiltValueField(wireName: 'MeterKey')
  String? get meterKey;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(MeterRecordBuilder builder) => builder
    ..meterName = ''
    ..meterKey = '';

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('meter')
          : FirebaseFirestore.instance.collectionGroup('meter');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('meter').doc();

  static Stream<MeterRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<MeterRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  MeterRecord._();
  factory MeterRecord([void Function(MeterRecordBuilder) updates]) =
      _$MeterRecord;

  static MeterRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createMeterRecordData({
  String? meterName,
  String? meterKey,
}) {
  final firestoreData = serializers.toFirestore(
    MeterRecord.serializer,
    MeterRecord((t) => t
      ..meterName = meterName
      ..meterKey = meterKey),
  );

  return firestoreData;
}
