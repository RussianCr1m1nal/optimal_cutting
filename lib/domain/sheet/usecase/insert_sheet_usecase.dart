import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/domain/sheet/repository/sheet_repository.dart';

@singleton
class InsertSheetUseCase {
  final SheetRepository _sheetRepository;

  InsertSheetUseCase(this._sheetRepository);

  Future<Either<Failure, Success>> call(Sheet sheet) async {
    try {
      await _sheetRepository.insertSheet(sheet);
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
