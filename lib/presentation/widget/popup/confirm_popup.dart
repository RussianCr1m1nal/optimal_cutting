import 'package:flutter/material.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';

class ConfirmPopup extends PopupRoute<bool> {
  final String title;

  ConfirmPopup({
    required this.title,
  });

  @override
  Color? get barrierColor => AppColors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: AppColors.white,
            ),
            height: 190,
            width: MediaQuery.of(context).size.width - 32,
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.divider,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Center(
                            child: Text(
                              'Да',
                              style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.blue),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              'Отмена',
                              style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
