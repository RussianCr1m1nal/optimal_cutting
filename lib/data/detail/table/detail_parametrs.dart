import 'package:drift/drift.dart';

class DetailParametrs extends Table {
  TextColumn get id => text().withLength(max: 128)();
  TextColumn get detail => text().withLength(max: 128)();
  TextColumn get name => text()();
  IntColumn get value => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
