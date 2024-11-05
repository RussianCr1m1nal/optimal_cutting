import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/data/database/database.dart';
import 'package:optimal_cutting/data/detail/datasource/detail_datasource.dart';
import 'package:optimal_cutting/data/detail/model/detail_expand.dart';

@Singleton(as: DetailDataSource)
class DetailDataSourceImpl extends DetailDataSource {
  final AppDataBase _dataBase;

  DetailDataSourceImpl(this._dataBase);

  @override
  Future<void> deleteDetail(String id) async {
    await _dataBase.detailDao.deleteDetail(id);
  }

  @override
  Future<void> deleteDetailParametr(String id) async {
    await _dataBase.detailDao.deleteDetailParametr(id);
  }

  @override
  Future<void> insertDetail(Detail detail) async {
    await _dataBase.detailDao.insertDetail(detail);
  }

  @override
  Future<void> insertDetailParametr(DetailParametr parametr) async {
    await _dataBase.detailDao.insertDetailParametr(parametr);
  }

  @override
  Stream<List<DetailParametr>> watchDetailParametrs(String detailId) {
    return _dataBase.detailDao.watchDetailParametrs(detailId);
  }

  @override
  Stream<List<DetailExpand>> watchDetails() {
    return _dataBase.detailDao.watchDetails();
  }
}
