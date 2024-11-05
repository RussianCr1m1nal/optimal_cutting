import 'package:optimal_cutting/data/database/database.dart' as db;
import 'package:optimal_cutting/data/detail/model/detail_expand.dart' as db;
import 'package:optimal_cutting/domain/detail/entity/detail.dart' as entity;
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart' as entity;

mixin DetailMapper {
  db.Detail mapEntityToDbDetail(entity.Detail detail) {
    return db.Detail(
      id: detail.id,
      name: detail.name,
    );
  }

  entity.Detail mapDbToEntityDetail(db.DetailExpand detailExpand) {
    return entity.Detail(
      id: detailExpand.detail.id,
      name: detailExpand.detail.name,
      parametrs: detailExpand.parametrs.map((e) => mapDbToEntityDetailParametr(e)).toList(),
    );
  }

  entity.DetailParametr mapDbToEntityDetailParametr(db.DetailParametr parametr) {
    return entity.DetailParametr(
      id: parametr.id,
      name: parametr.name,
      value: parametr.value,
    );
  }

  db.DetailParametr mapEntityToDbDetailParametr(entity.DetailParametr parametr, String detailId) {
    return db.DetailParametr(
      id: parametr.id,
      detail: detailId,
      name: parametr.name,
      value: parametr.value,
    );
  }
}
