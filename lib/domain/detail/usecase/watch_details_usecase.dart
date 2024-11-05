import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/repository/detail_repository.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';

@singleton
class WatchDetailsUseCase {
  final DetailRepository _detailRepository;

  WatchDetailsUseCase(this._detailRepository);

  Either<Failure, Stream<List<Detail>>> call() {
    try {
      return Right(_detailRepository.watchDetails());
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
