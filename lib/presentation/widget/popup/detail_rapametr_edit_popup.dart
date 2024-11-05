import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimal_cutting/common/theme/app_colors.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/detail/entity/detail_parametr.dart';
import 'package:optimal_cutting/presentation/bloc/detail_parametr_edit_bloc.dart';

class DetailParametrEditPopup extends PopupRoute<DetailParametr> {
  final DetailParametr parametr;
  final DetailParametrEditBloc detailParametrEditBloc;
  final void Function(DetailParametr) onDelete;

  DetailParametrEditPopup({
    required this.parametr,
    required this.onDelete,
  }) : detailParametrEditBloc = getIt<DetailParametrEditBloc>(
          param1: parametr,
        );

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
            height: 210,
            width: MediaQuery.of(context).size.width - 32,
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: detailParametrEditBloc.nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Название',
                    ),
                    onChanged: detailParametrEditBloc.updateName,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: detailParametrEditBloc.valueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Размер, мм',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: detailParametrEditBloc.updateValue,
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
                            Navigator.of(context).pop(detailParametrEditBloc.parametr);
                          },
                          child: Center(
                            child: Text(
                              'Сохранить',
                              style: Theme.of(context).textTheme.headline3?.copyWith(color: AppColors.blue),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onDelete.call(parametr);
                            Navigator.of(context).pop();
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
