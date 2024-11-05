import 'package:flutter/material.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/model/result.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({
    super.key,
    required this.result,
    required this.sheet,
  });

  final Result result;
  final Sheet sheet;

  final int widgetHeight = 250;

  @override
  Widget build(BuildContext context) {
    final double coefficient = widgetHeight / sheet.width;

    return Container(
      height: widgetHeight.toDouble() + 1,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black,
          ),
          right: BorderSide(
            color: Colors.black,
          ),
          top: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: Column(
        children: [
          ...result.details.map(
            (e) => Container(
              height: e.totalWidth * coefficient,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  e.totalWidth.toString(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          if (result.remainder != 0)
            Container(
              height: result.remainder * coefficient,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Остаток',
                  style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
