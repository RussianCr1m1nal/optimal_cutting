import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/presentation/bloc/detail_select_bloc.dart';
import 'package:optimal_cutting/presentation/widget/search_widget.dart';
import 'package:provider/provider.dart';

class DetailSelectScreen extends StatelessWidget {
  static const String routeName = "/detailsSelect";

  const DetailSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DetailSelectBloc>(
          create: (_) => getIt<DetailSelectBloc>(),
          dispose: (context, detailSelectBloc) {
            detailSelectBloc.dispose();
          },
        ),
      ],
      child: Consumer<DetailSelectBloc>(
        builder: (context, detailSelectBloc, child) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: AppColors.white,
              titleSpacing: 0,
              elevation: 1,
              shadowColor: AppColors.shadowAppBar,
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  context.pop();
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  ),
                ),
              ),
              title: Text(
                "Выберите детали",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            body: StreamBuilder<List<Detail>>(
              stream: detailSelectBloc.detailListStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox.shrink();
                }

                final List<Detail> details = snapshot.data!;

                return StreamBuilder<List<Detail>>(
                  stream: detailSelectBloc.detailSelectedStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SizedBox.shrink();
                    }

                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      slivers: [
                        SliverToBoxAdapter(
                          child: SearchWidget(
                            onChanged: (text) {
                              detailSelectBloc.search(text);
                            },
                            focusNode: detailSelectBloc.searchFocusNode,
                            placeholder: 'Поиск',
                            controller: detailSelectBloc.searchController,
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
                                      detailSelectBloc.selectDetail(e);
                                    },
                                    child: _DetailSelectItem(
                                      detail: e,
                                      selected: detailSelectBloc.detailSelected(e),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    );
                  },
                );
              },
            ),
            bottomNavigationBar: Container(
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.divider,
                    width: 1,
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  context.pop(detailSelectBloc.selectedDetails);
                },
                child: Center(
                  child: Text(
                    'Добавить',
                    style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.blue),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DetailSelectItem extends StatelessWidget {
  final Detail detail;
  final bool selected;

  const _DetailSelectItem({
    required this.detail,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: selected ? Border.all(color: AppColors.blue, width: 2) : null,
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
