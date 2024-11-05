import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';

abstract class SheetRepository {
  Stream<List<Sheet>> watchSheets();
  Future<void> insertSheet(Sheet sheet);
  Future<void> deleteSheet(String id);
}
