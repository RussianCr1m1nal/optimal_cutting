import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/entity/entity.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/domain/sheet/repository/sheet_repository.dart';

@singleton
class WatchSheetsUseCase {
  final SheetRepository _sheetRepository;

  WatchSheetsUseCase(this._sheetRepository);

  Either<Failure, Stream<List<Sheet>>> call() {
    try {
      return Right(_sheetRepository.watchSheets());
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
