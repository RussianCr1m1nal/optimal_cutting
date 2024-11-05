import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/repository/detail_repository.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';

@singleton
class DeleteDetailUseCase {
  final DetailRepository _detailRepository;

  DeleteDetailUseCase(this._detailRepository);

  Future<Either<Failure, Success>> call(String id) async {
    try {
      await _detailRepository.deleteDetail(id);
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
