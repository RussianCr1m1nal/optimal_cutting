import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';
import 'package:optimal_cutting/domain/detail/repository/detail_repository.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';

@singleton
class WatchDetailParametrsUseCase {
  final DetailRepository _detailRepository;

  WatchDetailParametrsUseCase(this._detailRepository);

  Either<Failure, Stream<List<DetailParametr>>> call(String detailId) {
    try {
      return Right(_detailRepository.watchDetailParametrs(detailId));
    } catch (e, s) {
      return Left(
        Failure(
          exception: e,
          stackTrace: s,
          message: e.toString(),
        ),
      );
    }
  }
}
