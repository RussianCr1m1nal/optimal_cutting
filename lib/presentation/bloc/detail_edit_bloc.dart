import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';
import 'package:optimal_cutting/domain/detail/usecase/delete_detail_parametr_usecase.dart';
import 'package:optimal_cutting/domain/detail/usecase/delete_detail_usecase.dart';
import 'package:optimal_cutting/domain/detail/usecase/insert_detail_parametr_usecase.dart';
import 'package:optimal_cutting/domain/detail/usecase/insert_detail_usecase.dart';
import 'package:optimal_cutting/domain/detail/usecase/watch_detail_parametrs_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

@injectable
class DetailEditBloc {
  final InsertDetailUseCase _insertDetailUseCase;
  final DeleteDetailUseCase _deleteDetailUseCase;

  final WatchDetailParametrsUseCase _watchDetailParametrsUseCase;
  final InsertDetailParametrUseCase _insertDetailParametrUseCase;
  final DeleteDetailParametrUseCase _deleteDetailParametrUseCase;

  Detail detail;

  TextEditingController nameController;

  final BehaviorSubject<Detail> _detailSubject;
  Stream<Detail> get detailStream => _detailSubject.stream;

  final BehaviorSubject<List<DetailParametr>> _parametrListSubject = BehaviorSubject<List<DetailParametr>>.seeded([]);
  StreamSubscription<List<DetailParametr>>? _parametrListSubscription;
  Stream<List<DetailParametr>> get parametrListStream => _parametrListSubject.stream;

  DetailEditBloc(
    this._insertDetailUseCase,
    this._deleteDetailUseCase,
    this._watchDetailParametrsUseCase,
    this._insertDetailParametrUseCase,
    this._deleteDetailParametrUseCase, {
    @factoryParam required this.detail,
  })  : _detailSubject = BehaviorSubject<Detail>.seeded(detail),
        nameController = TextEditingController(text: detail.name) {
    _watchDetailParametrs();
  }

  _watchDetailParametrs() {
    _watchDetailParametrsUseCase(_detailSubject.value.id).fold((failure) {
      print(failure.message);
    }, (parametrsStream) {
      _parametrListSubscription?.cancel();
      _parametrListSubscription = parametrsStream.listen((parametrs) {
        _parametrListSubject.add(parametrs);
      });
    });
  }

  void updateName(String newName) {
    _detailSubject.add(_detailSubject.value.copyWith(name: newName));
  }

  void updateDetail() async {
    (await _insertDetailUseCase(_detailSubject.value)).fold((failure) {
      print(failure.message);
    }, (r) {});
  }

  void deleteDetail() async {
    (await _deleteDetailUseCase(_detailSubject.value.id)).fold((failure) {
      print(failure.message);
    }, (r) {});
  }

  void updateParametr(DetailParametr parametr) async {
    (await _insertDetailParametrUseCase(parametr, _detailSubject.value.id)).fold((failure) {
      print(failure.message);
    }, (r) {});
  }

  void deleteParametr(DetailParametr parametr) async {
    (await _deleteDetailParametrUseCase(parametr.id)).fold((failure) {
      print(failure.message);
    }, (r) {});
  }

  DetailParametr getNewParametr() {
    return DetailParametr(
      id: const Uuid().v4(),
      name: '',
      value: 0,
    );
  }

  void dispose() {
    _detailSubject.close();
    _parametrListSubscription?.cancel();
    _parametrListSubject.close();
    nameController.dispose();
  }
}
