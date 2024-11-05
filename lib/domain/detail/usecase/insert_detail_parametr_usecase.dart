import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';
import 'package:optimal_cutting/domain/detail/repository/detail_repository.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';

@singleton
class InsertDetailParametrUseCase {
  final DetailRepository _detailRepository;

  InsertDetailParametrUseCase(this._detailRepository);

  Future<Either<Failure, Success>> call(DetailParametr parametr, String detailId) async {
    try {
      await _detailRepository.insertDetailParametr(parametr, detailId);
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
