import 'package:flutter/material.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';

class MainMenuAnimatedItem extends StatelessWidget {
  final IconData icon;
  final IconData? subIcon;
  final Function()? onTab;
  final Animation<Offset> animationIcon;
  final Animation<Offset> animationIndicator;

  const MainMenuAnimatedItem({
    super.key,
    required this.icon,
    this.subIcon,
    this.onTab,
    required this.animationIcon,
    required this.animationIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 52 + MediaQuery.of(context).padding.bottom,
        padding: const EdgeInsets.only(top: 12),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: animationIcon,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: animationIcon.value,
                    child: child,
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          icon,
                          color: AppColors.black,
                          size: 24,
                        ),
                      ),
                      if (subIcon != null)
                        Positioned(
                          bottom: 0,
                          right: -0,
                          child: Container(
                            height: 10,
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              subIcon,
                              color: AppColors.black,
                              size: 13,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: animationIndicator,
                builder: (BuildContext context, Widget? child) {
                  return FractionalTranslation(
                    translation: animationIndicator.value,
                    child: child,
                  );
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
