import 'package:optimal_cutting/data/database/database.dart' as db;
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart' as entity;

mixin SheetMapper {
  entity.Sheet mapDbToEntitySheet(db.Sheet sheet) {
    return entity.Sheet(
      id: sheet.id,
      name: sheet.name,
      width: sheet.width,
    );
  }

  db.Sheet mapEntityToDbSheet(entity.Sheet sheet) {
    return db.Sheet(
      id: sheet.id,
      name: sheet.name,
      width: sheet.width,
    );
  }
}
