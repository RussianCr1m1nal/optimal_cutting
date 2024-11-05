import 'dart:math';

import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/model/result.dart';

class Solver {
  List<Result> solve(Sheet sheet, List<Detail> details) {
    final List<Detail> _details = [...details];
    List<Result> results = [];

    while (_details.isNotEmpty) {
      final List<List<int>> valueMatrix = _getMatrix(_details, sheet.width);

      final List<int> foundIndecies =
          _getDetailIndecies(valueMatrix, valueMatrix.length - 1, valueMatrix[0].length - 1, [], _details);

      List<Detail> foundDetails = foundIndecies.map((index) => _details[index]).toList();
      int sum = 0;

      for (var detail in foundDetails) {
        sum += detail.totalWidth;
      }

      results.add(
        Result(
          sheet: sheet,
          details: foundDetails,
          remainder: sheet.width - sum,
        ),
      );

      for (final index in foundIndecies) {
        _details.removeAt(index);
      }
    }

    return results;
  }

  List<List<int>> _getMatrix(List<Detail> details, int width) {
    final List<List<int>> valueMatrix = [];

    for (int i = 0; i < details.length + 1; i++) {
      valueMatrix.add([]);
      for (int j = 0; j < width; j++) {
        valueMatrix[i].add(0);
      }
    }

    for (int i = 1; i < valueMatrix.length; i++) {
      for (int j = 1; j < width; j++) {
        if (j + 1 >= details[i - 1].totalWidth) {
          valueMatrix[i][j] = max(
              valueMatrix[i - 1][j],
              valueMatrix[i - 1][j - details[i - 1].totalWidth < 0 ? 0 : j - details[i - 1].totalWidth] +
                  details[i - 1].totalWidth);
        } else {
          valueMatrix[i][j] = valueMatrix[i - 1][j];
        }
      }
    }

    return valueMatrix;
  }

  List<int> _getDetailIndecies(List<List<int>> matrix, int i, int j, List<int> indecies, List<Detail> details) {
    if (matrix[i][j] == 0) {
      return indecies;
    }

    if (matrix[i - 1][j] == matrix[i][j]) {
      return _getDetailIndecies(matrix, i - 1, j, indecies, details);
    }

    indecies.add(i - 1);

    return _getDetailIndecies(
        matrix, i - 1, j - details[i - 1].totalWidth < 0 ? 0 : j - details[i - 1].totalWidth, indecies, details);
  }
}
