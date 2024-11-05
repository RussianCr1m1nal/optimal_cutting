import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/bloc/sheet_select_bloc.dart';
import 'package:optimal_cutting/presentation/widget/item/sheet_list_item.dart';
import 'package:optimal_cutting/presentation/widget/search_widget.dart';
import 'package:provider/provider.dart';

class SheetSelectScreen extends StatelessWidget {
  static const String routeName = "/selectSheet";

  const SheetSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SheetSelectBloc>(
          create: (_) => getIt<SheetSelectBloc>(),
          dispose: (context, sheetSelectBloc) {
            sheetSelectBloc.dispose();
          },
        ),
      ],
      child: Consumer<SheetSelectBloc>(
        builder: (context, sheetSelectBloc, child) {
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
                "Выберите лист",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            body: StreamBuilder<List<Sheet>>(
              stream: sheetSelectBloc.sheetListStream,
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
                          sheetSelectBloc.search(text);
                        },
                        focusNode: sheetSelectBloc.searchFocusNode,
                        placeholder: 'Поиск',
                        controller: sheetSelectBloc.searchController,
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
                                  context.pop(e);
                                },
                                child: SheetListItem(sheet: e),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
