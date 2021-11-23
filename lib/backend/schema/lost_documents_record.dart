import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'lost_documents_record.g.dart';

abstract class LostDocumentsRecord
    implements Built<LostDocumentsRecord, LostDocumentsRecordBuilder> {
  static Serializer<LostDocumentsRecord> get serializer =>
      _$lostDocumentsRecordSerializer;

  @nullable
  String get title;

  @nullable
  String get description;

  @nullable
  @BuiltValueField(wireName: 'date_added')
  DateTime get dateAdded;

  @nullable
  BuiltList<String> get images;

  @nullable
  DocumentReference get author;

  @nullable
  int get views;

  @nullable
  BuiltList<DocumentReference> get viewers;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(LostDocumentsRecordBuilder builder) => builder
    ..title = ''
    ..description = ''
    ..images = ListBuilder()
    ..views = 0
    ..viewers = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('lost_documents');

  static Stream<LostDocumentsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  LostDocumentsRecord._();
  factory LostDocumentsRecord(
          [void Function(LostDocumentsRecordBuilder) updates]) =
      _$LostDocumentsRecord;

  static LostDocumentsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createLostDocumentsRecordData({
  String title,
  String description,
  DateTime dateAdded,
  DocumentReference author,
  int views,
}) =>
    serializers.toFirestore(
        LostDocumentsRecord.serializer,
        LostDocumentsRecord((l) => l
          ..title = title
          ..description = description
          ..dateAdded = dateAdded
          ..images = null
          ..author = author
          ..views = views
          ..viewers = null));
