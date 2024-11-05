import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/model/result.dart';
import 'package:optimal_cutting/presentation/utils/pdf_editor.dart';
import 'package:optimal_cutting/presentation/utils/solver.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CuttingBloc {
  final Solver solver = Solver();

  final BehaviorSubject<Sheet?> _sheetSubject = BehaviorSubject<Sheet?>.seeded(null);
  Stream<Sheet?> get sheetStream => _sheetSubject.stream;

  final BehaviorSubject<List<Detail>> _detailListSubject = BehaviorSubject<List<Detail>>.seeded([]);
  Stream<List<Detail>> get detailListStream => _detailListSubject.stream;

  final BehaviorSubject<List<Result>> _resultsSubject = BehaviorSubject<List<Result>>.seeded([]);

  Stream<List<Result>> get resultsStream => _resultsSubject.stream;

  final BehaviorSubject<int> _pageSubject = BehaviorSubject<int>.seeded(0);
  Stream<int> get pageStream => _pageSubject.stream;

  int get currentPage => _pageSubject.value;

  Map<Detail, int> get detailsGrouped {
    final Map<Detail, int> groupedDetails = {};

    for (final detail in _detailListSubject.value..sort((a, b) => a.name.compareTo(b.name))) {
      if (groupedDetails.containsKey(detail)) {
        groupedDetails[detail] = (_detailListSubject.value.where((element) => element.id == detail.id)).length;
      } else {
        groupedDetails.addEntries([
          MapEntry(detail, (_detailListSubject.value.where((element) => element.id == detail.id)).length),
        ]);
      }
    }

    return groupedDetails;
  }

  void nextPage(BuildContext context) {
    if (currentPage == _resultsSubject.value.length - 1) {
      return;
    }

    _pageSubject.add(currentPage + 1);
    DefaultTabController.of(context).animateTo(currentPage);
  }

  void previousPage(BuildContext context) {
    if (currentPage == 0) {
      return;
    }

    _pageSubject.add(currentPage - 1);
    DefaultTabController.of(context).animateTo(currentPage);
  }

  void resetCurrentPage() {
    _pageSubject.add(0);
  }

  void setSheet(Sheet sheet) {
    _sheetSubject.add(sheet);
    _resetRsults();
  }

  void addDetails(List<Detail> details) {
    _detailListSubject.add([..._detailListSubject.value, ...details]);
  }

  void removeDetail(Detail detail) {
    final details = [..._detailListSubject.value];
    final foundDetail = details.firstWhere((element) => element.id == detail.id);

    details.remove(foundDetail);

    _detailListSubject.add(details);
  }

  void solveCurrent() {
    if (_sheetSubject.value == null || _detailListSubject.value.isEmpty) {
      return;
    }

    _resultsSubject.add(solver.solve(_sheetSubject.value!, _detailListSubject.value));

    if (currentPage + 1 > _resultsSubject.value.length) {
      _pageSubject.add(_resultsSubject.value.length - 1);
    }
  }

  Future<File> getSolutionPdf() async {
    return await PdfEditor().getSolutionPdf(_resultsSubject.value);
  }

  _resetRsults() {
    _resultsSubject.add([]);
  }

  void dispose() {
    _sheetSubject.close();
    _detailListSubject.close();
    _resultsSubject.close();
  }
}
