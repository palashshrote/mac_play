import 'dart:async';
import 'index.dart';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'borewell_record.g.dart';

abstract class BorewellRecord
    implements Built<BorewellRecord, BorewellRecordBuilder> {
  static Serializer<BorewellRecord> get serializer =>
      _$borewellRecordSerializer;

  @BuiltValueField(wireName: 'BorewellName')
  String? get borewellName;

  @BuiltValueField(wireName: 'BorewellKey')
  String? get borewellKey;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(BorewellRecordBuilder builder) => builder
    ..borewellName = ''
    ..borewellKey = '';

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('borewell')
          : FirebaseFirestore.instance.collectionGroup('borewell');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('borewell').doc();

  static Stream<BorewellRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<BorewellRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  BorewellRecord._();
  factory BorewellRecord([void Function(BorewellRecordBuilder) updates]) =
      _$BorewellRecord;

  static BorewellRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createBorewellRecordData({
  String? borewellName,
  String? borewellKey,
}) {
  final firestoreData = serializers.toFirestore(
    BorewellRecord.serializer,
    BorewellRecord((t) => t
      ..borewellName = borewellName
      ..borewellKey = borewellKey),
  );

  return firestoreData;
}
