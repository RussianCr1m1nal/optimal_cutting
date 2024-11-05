import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/data/database/database.dart';
import 'package:optimal_cutting/data/sheet/datasource/sheet_datasource.dart';

@Singleton(as: SheetDataSource)
class SheetDataSourceImpl extends SheetDataSource {
  final AppDataBase _dataBase;

  SheetDataSourceImpl(this._dataBase);

  @override
  Stream<List<Sheet>> watchSheets() {
    return _dataBase.sheetDao.watchSheets();
  }

  @override
  Future<void> deleteSheet(String id) async {
    await _dataBase.sheetDao.deleteSheet(id);
  }

  @override
  Future<void> insertSheet(Sheet sheet) async {
    await _dataBase.sheetDao.insertSheet(sheet);
  }
}
