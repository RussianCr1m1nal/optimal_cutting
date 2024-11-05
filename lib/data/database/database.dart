import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/data/detail/dao/detail_dao.dart';
import 'package:optimal_cutting/data/detail/table/detail_parametrs.dart';
import 'package:optimal_cutting/data/detail/table/details.dart';
import 'package:optimal_cutting/data/sheet/dao/sheet_dao.dart';
import 'package:optimal_cutting/data/sheet/table/sheets.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final folder = await getApplicationDocumentsDirectory();
    final file = File(path.join(folder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  Sheets,
  Details,
  DetailParametrs,
], daos: [
  SheetDao,
  DetailDao,
])
@Singleton()
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
