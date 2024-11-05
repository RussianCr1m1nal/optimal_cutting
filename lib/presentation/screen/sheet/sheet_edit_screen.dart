import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:optimal_cutting/common/icons/custom_icons.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/bloc/sheet_edit_bloc.dart';
import 'package:optimal_cutting/presentation/widget/popup/confirm_popup.dart';
import 'package:provider/provider.dart';

class SheetEditScreen extends StatelessWidget {
  final Sheet sheet;

  static const String routeName = "/sheet";

  const SheetEditScreen({
    super.key,
    required this.sheet,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SheetEditBloc>(
          create: (_) => getIt<SheetEditBloc>(param1: sheet),
          dispose: (context, sheetEditBloc) {
            sheetEditBloc.dispose();
          },
        ),
      ],
      child: Consumer<SheetEditBloc>(
        builder: (context, sheetEditBloc, child) {
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
                "Лист",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            body: StreamBuilder<Sheet>(
              stream: sheetEditBloc.sheetStream,
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
                          controller: sheetEditBloc.nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Название',
                          ),
                          onChanged: sheetEditBloc.updateName,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 16.0),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          controller: sheetEditBloc.widthController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ширина, мм',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: sheetEditBloc.updateWidth,
                        ),
                      ),
                    ),
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
                        sheetEditBloc.updateSheet();
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
                            title: "Вы уверены, что хотите удалить лист ${sheetEditBloc.sheet.name}?",
                          ),
                        );

                        if (result == true) {
                          sheetEditBloc.deleteSheet();
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
