import 'package:flutter/material.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';

class SheetListItem extends StatelessWidget {
  final Sheet sheet;

  const SheetListItem({
    super.key,
    required this.sheet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                sheet.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Text(
              "${sheet.width.toString()}мм",
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: AppColors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
