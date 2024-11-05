import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/domain/sheet/usecase/watch_sheets_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

@injectable
class SheetListBloc {
  final WatchSheetsUseCase _watchSheetsUseCase;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final BehaviorSubject<List<Sheet>> _sheetListSubject = BehaviorSubject<List<Sheet>>.seeded([]);
  StreamSubscription<List<Sheet>>? _sheetListSubscription;

  Stream<List<Sheet>> get sheetListStream => _sheetListSubject.stream;

  SheetListBloc(this._watchSheetsUseCase) {
    _watchSheets();
  }

  _watchSheets() {
    _watchSheetsUseCase().fold((failure) {
      print(failure.message);
    }, (sheetStream) {
      _sheetListSubscription?.cancel();
      _sheetListSubscription = sheetStream.listen((sheets) {
        _sheetListSubject.add(sheets);
      });
    });
  }

  void search(String value) {}

  Sheet getNewSheet() {
    return Sheet(
      id: const Uuid().v4(),
      name: '',
      width: 0,
    );
  }

  void dispose() {
    _sheetListSubscription?.cancel();
    _sheetListSubject.close();
  }
}
