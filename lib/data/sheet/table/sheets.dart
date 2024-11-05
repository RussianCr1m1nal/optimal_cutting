import 'package:drift/drift.dart';

class Sheets extends Table {
  TextColumn get id => text().withLength(max: 128)();
  TextColumn get name => text()();
  IntColumn get width => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
