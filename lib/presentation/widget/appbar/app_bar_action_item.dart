import 'package:flutter/material.dart';

class AppBarActionItem extends StatelessWidget{
  final Function()? onTap;
  final Icon icon;
  final Color? color;

  const AppBarActionItem({
    super.key,
    required this.icon,
    this.onTap,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Center(
        child: Container(
          width: 40,
          height: 26,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: icon,
        ),
      ),
      onTap: () async {
        onTap?.call();
      },
    );
  }
}
