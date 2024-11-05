// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SheetsTable extends Sheets with TableInfo<$SheetsTable, Sheet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SheetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, width];
  @override
  String get aliasedName => _alias ?? 'sheets';
  @override
  String get actualTableName => 'sheets';
  @override
  VerificationContext validateIntegrity(Insertable<Sheet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sheet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sheet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width'])!,
    );
  }

  @override
  $SheetsTable createAlias(String alias) {
    return $SheetsTable(attachedDatabase, alias);
  }
}

class Sheet extends DataClass implements Insertable<Sheet> {
  final String id;
  final String name;
  final int width;
  const Sheet({required this.id, required this.name, required this.width});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['width'] = Variable<int>(width);
    return map;
  }

  SheetsCompanion toCompanion(bool nullToAbsent) {
    return SheetsCompanion(
      id: Value(id),
      name: Value(name),
      width: Value(width),
    );
  }

  factory Sheet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sheet(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      width: serializer.fromJson<int>(json['width']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'width': serializer.toJson<int>(width),
    };
  }

  Sheet copyWith({String? id, String? name, int? width}) => Sheet(
        id: id ?? this.id,
        name: name ?? this.name,
        width: width ?? this.width,
      );
  @override
  String toString() {
    return (StringBuffer('Sheet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('width: $width')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, width);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sheet &&
          other.id == this.id &&
          other.name == this.name &&
          other.width == this.width);
}

class SheetsCompanion extends UpdateCompanion<Sheet> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> width;
  const SheetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.width = const Value.absent(),
  });
  SheetsCompanion.insert({
    required String id,
    required String name,
    required int width,
  })  : id = Value(id),
        name = Value(name),
        width = Value(width);
  static Insertable<Sheet> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? width,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (width != null) 'width': width,
    });
  }

  SheetsCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? width}) {
    return SheetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      width: width ?? this.width,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SheetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('width: $width')
          ..write(')'))
        .toString();
  }
}

class $DetailsTable extends Details with TableInfo<$DetailsTable, Detail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'details';
  @override
  String get actualTableName => 'details';
  @override
  VerificationContext validateIntegrity(Insertable<Detail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Detail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Detail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $DetailsTable createAlias(String alias) {
    return $DetailsTable(attachedDatabase, alias);
  }
}

class Detail extends DataClass implements Insertable<Detail> {
  final String id;
  final String name;
  const Detail({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  DetailsCompanion toCompanion(bool nullToAbsent) {
    return DetailsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Detail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Detail(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Detail copyWith({String? id, String? name}) => Detail(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Detail(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Detail && other.id == this.id && other.name == this.name);
}

class DetailsCompanion extends UpdateCompanion<Detail> {
  final Value<String> id;
  final Value<String> name;
  const DetailsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  DetailsCompanion.insert({
    required String id,
    required String name,
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Detail> custom({
    Expression<String>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  DetailsCompanion copyWith({Value<String>? id, Value<String>? name}) {
    return DetailsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetailsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $DetailParametrsTable extends DetailParametrs
    with TableInfo<$DetailParametrsTable, DetailParametr> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetailParametrsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
      'detail', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
      'value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, detail, name, value];
  @override
  String get aliasedName => _alias ?? 'detail_parametrs';
  @override
  String get actualTableName => 'detail_parametrs';
  @override
  VerificationContext validateIntegrity(Insertable<DetailParametr> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    } else if (isInserting) {
      context.missing(_detailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetailParametr map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetailParametr(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      detail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $DetailParametrsTable createAlias(String alias) {
    return $DetailParametrsTable(attachedDatabase, alias);
  }
}

class DetailParametr extends DataClass implements Insertable<DetailParametr> {
  final String id;
  final String detail;
  final String name;
  final int value;
  const DetailParametr(
      {required this.id,
      required this.detail,
      required this.name,
      required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['detail'] = Variable<String>(detail);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<int>(value);
    return map;
  }

  DetailParametrsCompanion toCompanion(bool nullToAbsent) {
    return DetailParametrsCompanion(
      id: Value(id),
      detail: Value(detail),
      name: Value(name),
      value: Value(value),
    );
  }

  factory DetailParametr.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetailParametr(
      id: serializer.fromJson<String>(json['id']),
      detail: serializer.fromJson<String>(json['detail']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<int>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'detail': serializer.toJson<String>(detail),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<int>(value),
    };
  }

  DetailParametr copyWith(
          {String? id, String? detail, String? name, int? value}) =>
      DetailParametr(
        id: id ?? this.id,
        detail: detail ?? this.detail,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('DetailParametr(')
          ..write('id: $id, ')
          ..write('detail: $detail, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, detail, name, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailParametr &&
          other.id == this.id &&
          other.detail == this.detail &&
          other.name == this.name &&
          other.value == this.value);
}

class DetailParametrsCompanion extends UpdateCompanion<DetailParametr> {
  final Value<String> id;
  final Value<String> detail;
  final Value<String> name;
  final Value<int> value;
  const DetailParametrsCompanion({
    this.id = const Value.absent(),
    this.detail = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
  });
  DetailParametrsCompanion.insert({
    required String id,
    required String detail,
    required String name,
    required int value,
  })  : id = Value(id),
        detail = Value(detail),
        name = Value(name),
        value = Value(value);
  static Insertable<DetailParametr> custom({
    Expression<String>? id,
    Expression<String>? detail,
    Expression<String>? name,
    Expression<int>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (detail != null) 'detail': detail,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
    });
  }

  DetailParametrsCompanion copyWith(
      {Value<String>? id,
      Value<String>? detail,
      Value<String>? name,
      Value<int>? value}) {
    return DetailParametrsCompanion(
      id: id ?? this.id,
      detail: detail ?? this.detail,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetailParametrsCompanion(')
          ..write('id: $id, ')
          ..write('detail: $detail, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  late final $SheetsTable sheets = $SheetsTable(this);
  late final $DetailsTable details = $DetailsTable(this);
  late final $DetailParametrsTable detailParametrs =
      $DetailParametrsTable(this);
  late final SheetDao sheetDao = SheetDao(this as AppDataBase);
  late final DetailDao detailDao = DetailDao(this as AppDataBase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [sheets, details, detailParametrs];
}
