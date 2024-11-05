import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/bloc/sheet_list_bloc.dart';
import 'package:optimal_cutting/presentation/screen/sheet/sheet_edit_screen.dart';
import 'package:optimal_cutting/presentation/widget/appbar/app_bar_action_item.dart';
import 'package:optimal_cutting/presentation/widget/appbar/app_bar_action_wrapper.dart';
import 'package:optimal_cutting/presentation/widget/item/sheet_list_item.dart';
import 'package:optimal_cutting/presentation/widget/menu/main_menu_wrapper.dart';
import 'package:optimal_cutting/presentation/widget/search_widget.dart';
import 'package:provider/provider.dart';

class SheetListScreen extends StatelessWidget {
  static const String routeName = "/sheets";

  const SheetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SheetListBloc>(
          create: (_) => getIt<SheetListBloc>(),
          dispose: (context, sheetListBloc) {
            sheetListBloc.dispose();
          },
        ),
      ],
      child: Consumer<SheetListBloc>(
        builder: (context, sheetListBloc, child) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: AppColors.white,
              titleSpacing: 0,
              elevation: 1,
              shadowColor: AppColors.shadowAppBar,
              title: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Листы",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              actions: [
                AppBarActionWrapper(
                  children: [
                    AppBarActionItem(
                      icon: const Icon(
                        Icons.add,
                        size: 24,
                        color: AppColors.black,
                      ),
                      onTap: () async {
                        context.push(SheetEditScreen.routeName, extra: sheetListBloc.getNewSheet());
                      },
                    ),
                  ],
                ),
              ],
            ),
            body: StreamBuilder<List<Sheet>>(
                stream: sheetListBloc.sheetListStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }

                  final List<Sheet> sheets = snapshot.data!;

                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    slivers: [
                      SliverToBoxAdapter(
                        child: SearchWidget(
                          onChanged: (text) {
                            sheetListBloc.search(text);
                          },
                          focusNode: sheetListBloc.searchFocusNode,
                          placeholder: 'Поиск',
                          controller: sheetListBloc.searchController,
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                      ...sheets
                          .map(
                            (e) => SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(SheetEditScreen.routeName, extra: e);
                                  },
                                  child: SheetListItem(sheet: e),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                }),
            bottomNavigationBar: const MainMenuWrapper(),
          );
        },
      ),
    );
  }
}
