import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/repository/detail_repository.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';

@singleton
class DeleteDetailParametrUseCase {
  final DetailRepository _detailRepository;

  DeleteDetailParametrUseCase(this._detailRepository);

  Future<Either<Failure, Success>> call(String id) async {
    try {
      await _detailRepository.deleteDetailParametr(id);
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
