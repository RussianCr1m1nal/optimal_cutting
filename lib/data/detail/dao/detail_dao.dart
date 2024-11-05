import 'package:drift/drift.dart';

import 'package:optimal_cutting/data/database/database.dart';
import 'package:optimal_cutting/data/detail/model/detail_expand.dart';
import 'package:optimal_cutting/data/detail/table/detail_parametrs.dart';
import 'package:optimal_cutting/data/detail/table/details.dart';

part 'detail_dao.g.dart';

@DriftAccessor(tables: [
  Details,
  DetailParametrs,
])
class DetailDao extends DatabaseAccessor<AppDataBase> with _$DetailDaoMixin {
  final AppDataBase dataBase;

  DetailDao(this.dataBase) : super(dataBase);

  Stream<List<DetailExpand>> watchDetails() {
    final rowsStream = select(details).join([
      leftOuterJoin(detailParametrs, detailParametrs.detail.equalsExp(details.id)),
    ]).watch();

    return rowsStream.map((element) {
      return element
          .fold(<String, DetailExpand>{}, (Map<String, DetailExpand> previousValue, row) {
            final detail = row.readTableOrNull(details);
            final parametr = row.readTableOrNull(detailParametrs);

            if (detail != null) {
              previousValue.update(detail.id, (value) {
                return DetailExpand(
                    detail: detail,
                    parametrs: parametr == null
                        ? value.parametrs
                        : [
                            ...value.parametrs,
                            parametr,
                          ]);
              }, ifAbsent: () {
                return DetailExpand(
                  detail: detail,
                  parametrs: parametr == null ? [] : [parametr],
                );
              });
            }

            return previousValue;
          })
          .values
          .toList();
    });
  }

  Future<void> insertDetail(Detail detail) async {
    await into(details).insert(detail, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteDetail(String id) async {
    await (delete(details)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<DetailParametr>> watchDetailParametrs(String detailId) {
    return (select(detailParametrs)..where((tbl) => tbl.detail.equals(detailId))).watch();
  }

  Future<void> insertDetailParametr(DetailParametr parametr) async {
    await into(detailParametrs).insert(parametr, mode: InsertMode.insertOrReplace);
  }

  Future<void> deleteDetailParametr(String id) async {
    await (delete(detailParametrs)..where((tbl) => tbl.id.equals(id))).go();
  }
}
