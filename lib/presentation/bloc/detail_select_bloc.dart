import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/usecase/watch_details_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

@injectable
class DetailSelectBloc {
  final WatchDetailsUseCase _watchDetailsUseCase;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final BehaviorSubject<List<Detail>> _detailListSubject = BehaviorSubject<List<Detail>>.seeded([]);
  StreamSubscription<List<Detail>>? _detailListSubscription;

  final BehaviorSubject<List<Detail>> _detailSelectedSubject = BehaviorSubject<List<Detail>>.seeded([]);

  List<Detail> get selectedDetails => _detailSelectedSubject.value;

  Stream<List<Detail>> get detailListStream => _detailListSubject.stream;
  Stream<List<Detail>> get detailSelectedStream => _detailSelectedSubject.stream;

  DetailSelectBloc(this._watchDetailsUseCase) {
    _watchDetails();
  }

  _watchDetails() {
    _watchDetailsUseCase().fold((failure) {
      print(failure.message);
    }, (detailStream) {
      _detailListSubscription?.cancel();
      _detailListSubscription = detailStream.listen((details) {
        _detailListSubject.add(details);
      });
    });
  }

  void search(String value) {}

  void selectDetail(Detail detail) {
    final details = [..._detailSelectedSubject.value];
    final foundDetail = details.firstWhereOrNull((element) => element.id == detail.id);

    if (foundDetail == null) {
      _detailSelectedSubject.add([...details, detail]);
    } else {
      details.remove(foundDetail);
      _detailSelectedSubject.add([...details]);
    }
  }

  bool detailSelected(Detail detail) {
    final details = [..._detailSelectedSubject.value];
    final foundDetail = details.firstWhereOrNull((element) => element.id == detail.id);

    return foundDetail != null;
  }

  void dispose() {
    _detailListSubscription?.cancel();
    _detailListSubject.close();
    _detailSelectedSubject.close();
  }
}
