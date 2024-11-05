import 'package:flutter/material.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';

class DetailListItem extends StatelessWidget {
  final Detail detail;

  const DetailListItem({
    super.key,
    required this.detail,
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
        child: Text(
          detail.name,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
