import 'package:drift/drift.dart';

import 'package:optimal_cutting/data/database/database.dart';
import 'package:optimal_cutting/data/sheet/table/sheets.dart';

part 'sheet_dao.g.dart';

@DriftAccessor(tables: [Sheets])
class SheetDao extends DatabaseAccessor<AppDataBase> with _$SheetDaoMixin {
  final AppDataBase dataBase;

  SheetDao(this.dataBase) : super(dataBase);

  Stream<List<Sheet>> watchSheets() {
    return select(sheets).watch();
  }

  Future<void> insertSheet(Sheet sheet) async {
    await into(sheets).insert(sheet, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteSheet(String id) async {
    await (delete(sheets)..where((tbl) => tbl.id.equals(id))).go();
  }
}
