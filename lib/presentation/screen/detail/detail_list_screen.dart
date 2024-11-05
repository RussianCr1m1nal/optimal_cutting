import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/presentation/bloc/detail_list_bloc.dart';
import 'package:optimal_cutting/presentation/screen/detail/detail_edit_screen.dart';
import 'package:optimal_cutting/presentation/widget/appbar/app_bar_action_item.dart';
import 'package:optimal_cutting/presentation/widget/appbar/app_bar_action_wrapper.dart';
import 'package:optimal_cutting/presentation/widget/item/detail_list_item.dart';
import 'package:optimal_cutting/presentation/widget/menu/main_menu_wrapper.dart';
import 'package:optimal_cutting/presentation/widget/search_widget.dart';
import 'package:provider/provider.dart';

class DetailListScreen extends StatelessWidget {
  static const String routeName = "/details";

  const DetailListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DetailListBloc>(
          create: (_) => getIt<DetailListBloc>(),
          dispose: (context, detailListBloc) {
            detailListBloc.dispose();
          },
        ),
      ],
      child: Consumer<DetailListBloc>(
        builder: (context, detailListBloc, child) {
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
                  "Детали",
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
                        context.push(DetailEditScreen.routeName, extra: detailListBloc.getNewDetail());
                      },
                    ),
                  ],
                ),
              ],
            ),
            body: StreamBuilder<List<Detail>>(
                stream: detailListBloc.detailListStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }

                  final List<Detail> details = snapshot.data!;

                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    slivers: [
                      SliverToBoxAdapter(
                        child: SearchWidget(
                          onChanged: (text) {
                            detailListBloc.search(text);
                          },
                          focusNode: detailListBloc.searchFocusNode,
                          placeholder: 'Поиск',
                          controller: detailListBloc.searchController,
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                      ...details
                          .map(
                            (e) => SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(DetailEditScreen.routeName, extra: e);
                                  },
                                  child: DetailListItem(detail: e),
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
