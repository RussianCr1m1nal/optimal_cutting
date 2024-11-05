
import 'package:optimal_cutting/data/database/database.dart';
import 'package:optimal_cutting/data/detail/model/detail_expand.dart';

abstract class DetailDataSource {
  Stream<List<DetailExpand>> watchDetails();
  Future<void> insertDetail(Detail detail);
  Future<void> deleteDetail(String id);

  Stream<List<DetailParametr>> watchDetailParametrs(String detailId);
  Future<void> insertDetailParametr(DetailParametr parametr);
  Future<void> deleteDetailParametr(String id);
}