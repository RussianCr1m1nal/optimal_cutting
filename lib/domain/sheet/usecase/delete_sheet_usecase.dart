import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';
import 'package:optimal_cutting/domain/sheet/repository/sheet_repository.dart';

@singleton
class DeleteSheetUseCase {
  final SheetRepository _sheetRepository;

  DeleteSheetUseCase(this._sheetRepository);

  Future<Either<Failure, Success>> call(String id) async {
    try {
      await _sheetRepository.deleteSheet(id);
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
