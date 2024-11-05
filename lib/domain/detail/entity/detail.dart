import 'package:flutter/foundation.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';

class Detail {
  String id;
  String name;
  List<DetailParametr> parametrs;

  int get totalWidth {
    int sum = 0;
    for (var parametr in parametrs) {
      sum += parametr.value;
    }

    return sum;
  }

  Detail({
    required this.id,
    this.name = '',
    this.parametrs = const [],
  });

  Detail copyWith({
    String? id,
    String? name,
    List<DetailParametr>? parametrs,
  }) {
    return Detail(
      id: id ?? this.id,
      name: name ?? this.name,
      parametrs: parametrs ?? this.parametrs,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Detail &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.name == name &&
      listEquals(
        other.parametrs,
        parametrs,
      );

  @override
  int get hashCode => id.hashCode;
}
