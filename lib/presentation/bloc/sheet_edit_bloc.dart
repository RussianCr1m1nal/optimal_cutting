import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/domain/sheet/usecase/delete_sheet_usecase.dart';
import 'package:optimal_cutting/domain/sheet/usecase/insert_sheet_usecase.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SheetEditBloc {
  final InsertSheetUseCase _insertSheetUseCase;
  final DeleteSheetUseCase _deleteSheetUseCase;

  TextEditingController nameController;
  TextEditingController widthController;

  final Sheet sheet;

  final BehaviorSubject<Sheet> _sheetSubject;

  Stream<Sheet> get sheetStream => _sheetSubject.stream;

  SheetEditBloc(
    this._insertSheetUseCase,
    this._deleteSheetUseCase, {
    @factoryParam required this.sheet,
  })  : _sheetSubject = BehaviorSubject<Sheet>.seeded(sheet),
        nameController = TextEditingController(text: sheet.name),
        widthController = TextEditingController(text: sheet.width.toString());

  void updateName(String newName) {
    _sheetSubject.add(
      _sheetSubject.value.copyWith(
        name: newName,
      ),
    );
  }

  void updateWidth(String newWidth) {
    final int width = int.tryParse(newWidth) ?? _sheetSubject.value.width;

    _sheetSubject.add(
      _sheetSubject.value.copyWith(
        width: width,
      ),
    );
  }

  void updateSheet() async {
    (await _insertSheetUseCase(_sheetSubject.value)).fold((failure) {
      print(failure.message);
    }, (r) {});
  }

  void deleteSheet() async {
    (await _deleteSheetUseCase(_sheetSubject.value.id)).fold((failure) {
      print(failure.message);
    }, (r) {});
  }

  void dispose() {
    _sheetSubject.close();
    nameController.dispose();
    widthController.dispose();
  }
}
