import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/data/sheet/datasource/sheet_datasource.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/domain/sheet/mapper/sheet_mapper.dart';
import 'package:optimal_cutting/domain/sheet/repository/sheet_repository.dart';

@Singleton(as: SheetRepository)
class SheetRepositoryImpl extends SheetRepository with SheetMapper {
  final SheetDataSource _sheetDataSource;

  SheetRepositoryImpl(this._sheetDataSource);

  @override
  Stream<List<Sheet>> watchSheets() {
    return _sheetDataSource.watchSheets().map(
          (sheets) => sheets
              .map(
                (e) => mapDbToEntitySheet(e),
              )
              .toList(),
        );
  }

  @override
  Future<void> deleteSheet(String id) async {
    await _sheetDataSource.deleteSheet(id);
  }

  @override
  Future<void> insertSheet(Sheet sheet) async {
    await _sheetDataSource.insertSheet(mapEntityToDbSheet(sheet));
  }
}
