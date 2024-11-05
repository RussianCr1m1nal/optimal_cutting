import 'package:optimal_cutting/data/database/database.dart';

abstract class SheetDataSource {
  Stream<List<Sheet>> watchSheets();
  Future<void> insertSheet(Sheet sheet);
  Future<void> deleteSheet(String id);
}
