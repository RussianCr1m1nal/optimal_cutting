import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class DetailParametrEditBloc {
  final BehaviorSubject<DetailParametr> _parametrSubject;

  DetailParametr initialparametr;
  DetailParametr get parametr => _parametrSubject.value;

  TextEditingController nameController;
  TextEditingController valueController;

  DetailParametrEditBloc({@factoryParam required this.initialparametr})
      : _parametrSubject = BehaviorSubject<DetailParametr>.seeded(initialparametr),
        nameController = TextEditingController(text: initialparametr.name),
        valueController = TextEditingController(text: initialparametr.value.toString());

  void updateName(String newName) {
    _parametrSubject.add(_parametrSubject.value.copyWith(name: newName));
  }

  void updateValue(String newValue) {
    int value = int.tryParse(newValue) ?? _parametrSubject.value.value;

    _parametrSubject.add(_parametrSubject.value.copyWith(value: value));
  }

  void dispose() {
    _parametrSubject.close();
  }
}
