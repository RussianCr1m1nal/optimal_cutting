import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/bloc/cutting_bloc.dart';
import 'package:optimal_cutting/presentation/model/result.dart';
import 'package:optimal_cutting/presentation/screen/detail/detail_select_screen.dart';
import 'package:optimal_cutting/presentation/screen/sheet/sheet_select_screen.dart';
import 'package:optimal_cutting/presentation/widget/item/result_item.dart';
import 'package:optimal_cutting/presentation/widget/menu/main_menu_wrapper.dart';
import 'package:provider/provider.dart';

class CuttingScreen extends StatelessWidget {
  static const String routeName = "/cutting";

  const CuttingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CuttingBloc>(
      builder: (context, cuttingBloc, child) {
        cuttingBloc.resetCurrentPage();

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
                "Расчет",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            actions: [
              StreamBuilder<List<Result>>(
                stream: cuttingBloc.resultsStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }

                  final List<Result> results = snapshot.data!;

                  if (results.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () async {
                        final result = await cuttingBloc.getSolutionPdf();
                        final o_result = await OpenFilex.open(result.path);
                        print(o_result);
                      },
                      child: const Icon(
                        Icons.save_outlined,
                        size: 24,
                        color: AppColors.black,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: StreamBuilder<Sheet?>(
            stream: cuttingBloc.sheetStream,
            builder: (context, snapshot) {
              final Sheet? selectedSheet = snapshot.data;

              return StreamBuilder<List<Detail>>(
                stream: cuttingBloc.detailListStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }

                  final List<Detail> details = snapshot.data!;

                  return StreamBuilder<List<Result>>(
                    stream: cuttingBloc.resultsStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const SizedBox.shrink();
                      }

                      final List<Result> results = snapshot.data!;

                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: _SheetSelectBlock(
                              selectedSheet: selectedSheet,
                              cuttingBloc: cuttingBloc,
                            ),
                          ),
                          ...cuttingBloc.detailsGrouped.entries.map(
                            (e) {
                              return SliverToBoxAdapter(
                                child: _DetailBlock(
                                  detailEntry: e,
                                  cuttingBloc: cuttingBloc,
                                ),
                              );
                            },
                          ).toList(),
                          SliverToBoxAdapter(
                            child: _AddDetailBlock(
                              cuttingBloc: cuttingBloc,
                            ),
                          ),
                          if (selectedSheet != null && details.isNotEmpty)
                            SliverToBoxAdapter(
                              child: _SolveBlock(
                                cuttingBloc: cuttingBloc,
                              ),
                            ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 8.0,
                            ),
                          ),
                          if (results.isNotEmpty)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'Листов необходимо для производства: ${results.length}',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                          if (results.isNotEmpty)
                            const SliverToBoxAdapter(
                              child: SizedBox(
                                height: 8.0,
                              ),
                            ),
                          if (results.isNotEmpty)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'Макет расположения деталей: ',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                          if (results.isNotEmpty)
                            const SliverToBoxAdapter(
                              child: SizedBox(
                                height: 8.0,
                              ),
                            ),
                          if (results.isNotEmpty)
                            SliverToBoxAdapter(
                              child: _ResultsBlock(
                                results: results,
                                selectedSheet: selectedSheet,
                                cuttingBloc: cuttingBloc,
                              ),
                            ),
                          if (results.isNotEmpty)
                            const SliverToBoxAdapter(
                              child: SizedBox(
                                height: 8.0,
                              ),
                            ),
                          if (results.isNotEmpty)
                            StreamBuilder<int>(
                              stream: cuttingBloc.pageStream,
                              builder: (context, snapshot) {
                                return SliverToBoxAdapter(
                                  child: Center(child: Text("${cuttingBloc.currentPage + 1}/${results.length}")),
                                );
                              },
                            ),
                          if (results.isNotEmpty)
                            const SliverToBoxAdapter(
                              child: SizedBox(
                                height: 8.0,
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
          bottomNavigationBar: const MainMenuWrapper(),
        );
      },
    );
  }
}

class _ResultsBlock extends StatelessWidget {
  final List<Result> results;
  final Sheet? selectedSheet;
  final CuttingBloc cuttingBloc;

  const _ResultsBlock({
    required this.results,
    required this.selectedSheet,
    required this.cuttingBloc,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: results.length,
      child: Builder(builder: (context) {
        return SizedBox(
          height: 251,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    cuttingBloc.previousPage(context);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_left),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ...results.map(
                      (e) {
                        return ResultItem(
                          result: e,
                          sheet: selectedSheet!,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    cuttingBloc.nextPage(context);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _SolveBlock extends StatelessWidget {
  final CuttingBloc cuttingBloc;

  const _SolveBlock({
    required this.cuttingBloc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cuttingBloc.solveCurrent();
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.divider,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            'Рассчитать',
            style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.blue),
          ),
        ),
      ),
    );
  }
}

class _AddDetailBlock extends StatelessWidget {
  final CuttingBloc cuttingBloc;

  const _AddDetailBlock({
    required this.cuttingBloc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DetailSelectScreen(),
          ),
        );

        if (result != null) {
          cuttingBloc.addDetails(result);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.divider,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            'Добавить детали',
            style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.blue),
          ),
        ),
      ),
    );
  }
}

class _DetailBlock extends StatelessWidget {
  final MapEntry<Detail, int> detailEntry;
  final CuttingBloc cuttingBloc;

  const _DetailBlock({
    required this.detailEntry,
    required this.cuttingBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                detailEntry.key.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  cuttingBloc.removeDetail(detailEntry.key);
                },
                child: Container(
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.remove,
                  ),
                ),
              ),
            ),
            Text(
              detailEntry.value.toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  cuttingBloc.addDetails([detailEntry.key]);
                },
                child: Container(
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
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

class _SheetSelectBlock extends StatelessWidget {
  final Sheet? selectedSheet;
  final CuttingBloc cuttingBloc;

  const _SheetSelectBlock({
    required this.selectedSheet,
    required this.cuttingBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (selectedSheet == null) {
          return GestureDetector(
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SheetSelectScreen(),
                ),
              );

              if (result != null) {
                cuttingBloc.setSheet(result);
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.divider,
                    width: 2,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Text(
                  'Выберите лист',
                  style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.blue),
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SheetSelectScreen(),
              ),
            );

            if (result != null) {
              cuttingBloc.setSheet(result);
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.divider,
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                selectedSheet!.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
        );
      },
    );
  }
}
