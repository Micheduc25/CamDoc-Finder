// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_documents_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LostDocumentsRecord> _$lostDocumentsRecordSerializer =
    new _$LostDocumentsRecordSerializer();

class _$LostDocumentsRecordSerializer
    implements StructuredSerializer<LostDocumentsRecord> {
  @override
  final Iterable<Type> types = const [
    LostDocumentsRecord,
    _$LostDocumentsRecord
  ];
  @override
  final String wireName = 'LostDocumentsRecord';

  @override
  Iterable<Object> serialize(
      Serializers serializers, LostDocumentsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dateAdded;
    if (value != null) {
      result
        ..add('date_added')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.images;
    if (value != null) {
      result
        ..add('images')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.author;
    if (value != null) {
      result
        ..add('author')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.views;
    if (value != null) {
      result
        ..add('views')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.viewers;
    if (value != null) {
      result
        ..add('viewers')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(DocumentReference, const [const FullType(Object)])
            ])));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  LostDocumentsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LostDocumentsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date_added':
          result.dateAdded = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'images':
          result.images.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'author':
          result.author = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'views':
          result.views = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'viewers':
          result.viewers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType(Object)])
              ])) as BuiltList<Object>);
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$LostDocumentsRecord extends LostDocumentsRecord {
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime dateAdded;
  @override
  final BuiltList<String> images;
  @override
  final DocumentReference<Object> author;
  @override
  final int views;
  @override
  final BuiltList<DocumentReference<Object>> viewers;
  @override
  final DocumentReference<Object> reference;

  factory _$LostDocumentsRecord(
          [void Function(LostDocumentsRecordBuilder) updates]) =>
      (new LostDocumentsRecordBuilder()..update(updates)).build();

  _$LostDocumentsRecord._(
      {this.title,
      this.description,
      this.dateAdded,
      this.images,
      this.author,
      this.views,
      this.viewers,
      this.reference})
      : super._();

  @override
  LostDocumentsRecord rebuild(
          void Function(LostDocumentsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LostDocumentsRecordBuilder toBuilder() =>
      new LostDocumentsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LostDocumentsRecord &&
        title == other.title &&
        description == other.description &&
        dateAdded == other.dateAdded &&
        images == other.images &&
        author == other.author &&
        views == other.views &&
        viewers == other.viewers &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, title.hashCode), description.hashCode),
                            dateAdded.hashCode),
                        images.hashCode),
                    author.hashCode),
                views.hashCode),
            viewers.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LostDocumentsRecord')
          ..add('title', title)
          ..add('description', description)
          ..add('dateAdded', dateAdded)
          ..add('images', images)
          ..add('author', author)
          ..add('views', views)
          ..add('viewers', viewers)
          ..add('reference', reference))
        .toString();
  }
}

class LostDocumentsRecordBuilder
    implements Builder<LostDocumentsRecord, LostDocumentsRecordBuilder> {
  _$LostDocumentsRecord _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  DateTime _dateAdded;
  DateTime get dateAdded => _$this._dateAdded;
  set dateAdded(DateTime dateAdded) => _$this._dateAdded = dateAdded;

  ListBuilder<String> _images;
  ListBuilder<String> get images =>
      _$this._images ??= new ListBuilder<String>();
  set images(ListBuilder<String> images) => _$this._images = images;

  DocumentReference<Object> _author;
  DocumentReference<Object> get author => _$this._author;
  set author(DocumentReference<Object> author) => _$this._author = author;

  int _views;
  int get views => _$this._views;
  set views(int views) => _$this._views = views;

  ListBuilder<DocumentReference<Object>> _viewers;
  ListBuilder<DocumentReference<Object>> get viewers =>
      _$this._viewers ??= new ListBuilder<DocumentReference<Object>>();
  set viewers(ListBuilder<DocumentReference<Object>> viewers) =>
      _$this._viewers = viewers;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  LostDocumentsRecordBuilder() {
    LostDocumentsRecord._initializeBuilder(this);
  }

  LostDocumentsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _dateAdded = $v.dateAdded;
      _images = $v.images?.toBuilder();
      _author = $v.author;
      _views = $v.views;
      _viewers = $v.viewers?.toBuilder();
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LostDocumentsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LostDocumentsRecord;
  }

  @override
  void update(void Function(LostDocumentsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LostDocumentsRecord build() {
    _$LostDocumentsRecord _$result;
    try {
      _$result = _$v ??
          new _$LostDocumentsRecord._(
              title: title,
              description: description,
              dateAdded: dateAdded,
              images: _images?.build(),
              author: author,
              views: views,
              viewers: _viewers?.build(),
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        _images?.build();

        _$failedField = 'viewers';
        _viewers?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LostDocumentsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
