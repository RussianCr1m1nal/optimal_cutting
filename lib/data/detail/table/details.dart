import 'package:drift/drift.dart';

class Details extends Table {
  TextColumn get id => text().withLength(max: 128)();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
