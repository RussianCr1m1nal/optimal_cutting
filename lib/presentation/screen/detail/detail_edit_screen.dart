import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/common/icons/custom_icons.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';
import 'package:optimal_cutting/presentation/bloc/detail_edit_bloc.dart';
import 'package:optimal_cutting/presentation/widget/popup/confirm_popup.dart';
import 'package:optimal_cutting/presentation/widget/popup/detail_rapametr_edit_popup.dart';
import 'package:provider/provider.dart';

class DetailEditScreen extends StatelessWidget {
  static const String routeName = "/detail";

  final Detail detail;

  const DetailEditScreen({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DetailEditBloc>(
          create: (_) => getIt<DetailEditBloc>(param1: detail),
          dispose: (context, detailEditBloc) {
            detailEditBloc.dispose();
          },
        ),
      ],
      child: Consumer<DetailEditBloc>(
        builder: (context, detailEditBloc, child) {
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
                "Деталь",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            body: StreamBuilder<Detail>(
              stream: detailEditBloc.detailStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SizedBox.shrink();
                }

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 16.0),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: detailEditBloc.nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Название',
                          ),
                          onChanged: detailEditBloc.updateName,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 16.0),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: StreamBuilder<List<DetailParametr>>(
                          stream: detailEditBloc.parametrListStream,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox.shrink();
                            }

                            final List<DetailParametr> parametrs = snapshot.data!;

                            if (parametrs.isEmpty) {
                              return GestureDetector(
                                onTap: () async {
                                  final parametr = await Navigator.of(context).push(
                                    DetailParametrEditPopup(
                                      parametr: detailEditBloc.getNewParametr(),
                                      onDelete: detailEditBloc.deleteParametr,
                                    ),
                                  );

                                  if (parametr != null) {
                                    detailEditBloc.updateParametr(parametr);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          size: 24,
                                          color: AppColors.grey,
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          "Добавить параметр",
                                          style: Theme.of(context).textTheme.headline3?.copyWith(
                                                color: AppColors.grey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: Text(
                                      'Параметры',
                                      style: Theme.of(context).textTheme.headline4?.copyWith(
                                            color: AppColors.grey,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: AppColors.divider,
                                  ),
                                  ...parametrs.map(
                                    (e) {
                                      return GestureDetector(
                                        onTap: () async {
                                          final parametr = await Navigator.of(context).push(
                                            DetailParametrEditPopup(
                                              parametr: e,
                                              onDelete: detailEditBloc.deleteParametr,
                                            ),
                                          );

                                          if (parametr != null) {
                                            detailEditBloc.updateParametr(parametr);
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
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    e.name,
                                                    style: Theme.of(context).textTheme.headline4,
                                                  ),
                                                ),
                                                Text(
                                                  "${e.value.toString()}мм",
                                                  style: Theme.of(context).textTheme.headline4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  GestureDetector(
                                    onTap: () async {
                                      final parametr = await Navigator.of(context).push(
                                        DetailParametrEditPopup(
                                          parametr: detailEditBloc.getNewParametr(),
                                          onDelete: detailEditBloc.deleteParametr,
                                        ),
                                      );

                                      if (parametr != null) {
                                        detailEditBloc.updateParametr(parametr);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            size: 16,
                                            color: AppColors.grey,
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            "Добавить параметр",
                                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                                  color: AppColors.grey,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
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
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        detailEditBloc.updateDetail();
                        context.pop();
                      },
                      child: Center(
                        child: Text(
                          'Сохранить',
                          style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.blue),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: AppColors.divider,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.of(context).push(
                          ConfirmPopup(
                            title: "Вы уверены, что хотите удалить деталь ${detailEditBloc.detail.name}?",
                          ),
                        );

                        if (result == true) {
                          detailEditBloc.deleteDetail();
                          context.pop();
                        }
                      },
                      child: Center(
                        child: Text(
                          'Удалить',
                          style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
