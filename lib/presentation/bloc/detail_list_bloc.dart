import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/usecase/watch_details_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

@injectable
class DetailListBloc {
  final WatchDetailsUseCase _watchDetailsUseCase;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final BehaviorSubject<List<Detail>> _detailListSubject = BehaviorSubject<List<Detail>>.seeded([]);
  StreamSubscription<List<Detail>>? _detailListSubscription;

  Stream<List<Detail>> get detailListStream => _detailListSubject.stream;

  DetailListBloc(this._watchDetailsUseCase) {
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

  Detail getNewDetail() {
    return Detail(
      id: const Uuid().v4(),
      name: '',
      parametrs: [],
    );
  }

  void dispose() {
    _detailListSubscription?.cancel();
    _detailListSubject.close();
  }
}
