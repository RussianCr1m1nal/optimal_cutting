import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';

class Result {
  final Sheet sheet;
  final List<Detail> details;
  final int remainder;

  Result({
    required this.sheet,
    this.details = const [],
    this.remainder = 0,
  });
}
