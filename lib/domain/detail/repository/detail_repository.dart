import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';

abstract class DetailRepository {
  Stream<List<Detail>> watchDetails();
  Future<void> insertDetail(Detail detail);
  Future<void> deleteDetail(String id);

  Stream<List<DetailParametr>> watchDetailParametrs(String detailId);
  Future<void> insertDetailParametr(DetailParametr parametr, String detailId);
  Future<void> deleteDetailParametr(String id);
}
