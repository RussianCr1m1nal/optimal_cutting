import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/repository/detail_repository.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';

@singleton
class InsertDetailUseCase {
  final DetailRepository _detailRepository;

  InsertDetailUseCase(this._detailRepository);

  Future<Either<Failure, Success>> call(Detail detail) async {
    try {
      await _detailRepository.insertDetail(detail);
      return Right(Success(message: 'OK'));
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
