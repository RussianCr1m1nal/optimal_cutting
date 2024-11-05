import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/common/icons/custom_icons.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/presentation/model/menu_item_model.dart';
import 'package:optimal_cutting/presentation/screen/cutting/cutting_screen.dart';
import 'package:optimal_cutting/presentation/screen/detail/detail_list_screen.dart';
import 'package:optimal_cutting/presentation/screen/sheet/sheet_list_screen.dart';
import 'package:optimal_cutting/presentation/widget/menu/main_menu_animated_item.dart';
import 'package:optimal_cutting/presentation/widget/menu/main_menu_item.dart';

class MainMenuWrapper extends StatefulWidget {
  const MainMenuWrapper({
    super.key,
  });

  @override
  _MainMenu createState() => _MainMenu();
}

class _MainMenu extends State<MainMenuWrapper> with TickerProviderStateMixin {
  late List<MainMenuItemModel> items;

  late Animation<Offset> _animationIcon;
  late Animation<Offset> _animationIndicator;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _animationIcon = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -3.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _animationIndicator = Tween<Offset>(
      begin: const Offset(0.0, 0.4),
      end: const Offset(0.0, -0.85),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _controller.forward();

    items = [
      MainMenuItemModel(
        path: CuttingScreen.routeName,
        icon: CustomIcons.scissors,
        buildTitle: (context) => "Cutting",
        onTab: (context) async {
          _navigate(CuttingScreen.routeName);
        },
      ),
      MainMenuItemModel(
        path: DetailListScreen.routeName,
        icon: CustomIcons.detail,
        buildTitle: (context) => "Details",
        onTab: (context) async {
          _navigate(DetailListScreen.routeName);
        },
      ),
      MainMenuItemModel(
        path: SheetListScreen.routeName,
        icon: CustomIcons.sheet,
        buildTitle: (context) => "Sheets",
        onTab: (context) async {
          _navigate(SheetListScreen.routeName);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).location;

    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: AppColors.shadowMainMenu, offset: Offset(0, -1)),
      ]),
      child: Material(
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...items.map((e) {
              return _itemBuilder(e, currentPath);
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _navigate(String routeName) async {
    await _controller.reverse();
    context.go(routeName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _itemBuilder(MainMenuItemModel item, String currentPath) {
    if (item.path == currentPath) {
      return Flexible(
        child: MainMenuAnimatedItem(
          icon: item.icon,
          animationIndicator: _animationIndicator,
          animationIcon: _animationIcon,
        ),
      );
    }

    return Flexible(
      child: MainMenuItem(
        icon: item.icon,
        onTab: item.onTab,
      ),
    );
  }
}
