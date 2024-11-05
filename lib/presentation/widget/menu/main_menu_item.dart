import 'package:flutter/material.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';

class MainMenuItem extends StatelessWidget {
  final IconData icon;
  final void Function(BuildContext context) onTab;

  const MainMenuItem({
    super.key,
    required this.icon,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab.call(context);
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: 48 + MediaQuery.of(context).padding.bottom,
        padding: const EdgeInsets.only(top: 12),
        alignment: Alignment.topCenter,
        child: Icon(
          icon,
          color: AppColors.grey,
          size: 24,
        ),
      ),
    );
  }
}
