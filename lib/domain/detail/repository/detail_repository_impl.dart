import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/data/detail/datasource/detail_datasource.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/mapper/detail_mapper.dart';
import 'package:optimal_cutting/domain/detail/repository/detail_repository.dart';

@Singleton(as: DetailRepository)
class DetailrepositoryImpl extends DetailRepository with DetailMapper {
  final DetailDataSource _detailDataSource;

  DetailrepositoryImpl(this._detailDataSource);

  @override
  Future<void> deleteDetail(String id) async {
    await _detailDataSource.deleteDetail(id);
  }

  @override
  Future<void> deleteDetailParametr(String id) async {
    await _detailDataSource.deleteDetailParametr(id);
  }

  @override
  Future<void> insertDetail(Detail detail) async {
    await _detailDataSource.insertDetail(mapEntityToDbDetail(detail));
  }

  @override
  Future<void> insertDetailParametr(DetailParametr parametr, String detailId) async {
    await _detailDataSource.insertDetailParametr(mapEntityToDbDetailParametr(parametr, detailId));
  }

  @override
  Stream<List<DetailParametr>> watchDetailParametrs(String detailId) {
    return _detailDataSource.watchDetailParametrs(detailId).map(
          (parametrs) => parametrs.map((e) => mapDbToEntityDetailParametr(e)).toList(),
        );
  }

  @override
  Stream<List<Detail>> watchDetails() {
    return _detailDataSource.watchDetails().map(
          (details) => details.map((e) => mapDbToEntityDetail(e)).toList(),
        );
  }
}
