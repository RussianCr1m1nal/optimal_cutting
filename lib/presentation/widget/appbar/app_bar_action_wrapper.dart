import 'package:flutter/material.dart';

class AppBarActionWrapper extends StatelessWidget {
  final List<Widget> children;

  const AppBarActionWrapper({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...children.map((element) => Row(
              children: [
                element,
                const SizedBox(
                  width: 6,
                )
              ],
            )),
        const SizedBox(
          width: 14,
        ),
      ],
    );
  }
}
