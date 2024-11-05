// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/database/database.dart' as _i3;
import '../data/detail/datasource/detail_datasource.dart' as _i5;
import '../data/detail/datasource/detail_datasource_impl.dart' as _i6;
import '../data/sheet/datasource/sheet_datasource.dart' as _i13;
import '../data/sheet/datasource/sheet_datasource_impl.dart' as _i14;
import '../domain/detail/entity/detail.dart' as _i24;
import '../domain/detail/entity/detail_parametr.dart' as _i8;
import '../domain/detail/repository/detail_repository.dart' as _i9;
import '../domain/detail/repository/detail_repository_impl.dart' as _i10;
import '../domain/detail/usecase/delete_detail_parametr_usecase.dart' as _i20;
import '../domain/detail/usecase/delete_detail_usecase.dart' as _i21;
import '../domain/detail/usecase/insert_detail_parametr_usecase.dart' as _i11;
import '../domain/detail/usecase/insert_detail_usecase.dart' as _i12;
import '../domain/detail/usecase/watch_detail_parametrs_usecase.dart' as _i17;
import '../domain/detail/usecase/watch_details_usecase.dart' as _i18;
import '../domain/sheet/entity/sheet.dart' as _i29;
import '../domain/sheet/repository/sheet_repository.dart' as _i15;
import '../domain/sheet/repository/sheet_repository_impl.dart' as _i16;
import '../domain/sheet/usecase/delete_sheet_usecase.dart' as _i22;
import '../domain/sheet/usecase/insert_sheet_usecase.dart' as _i27;
import '../domain/sheet/usecase/watch_sheets_usecase.dart' as _i19;
import '../presentation/bloc/cutting_bloc.dart' as _i4;
import '../presentation/bloc/detail_edit_bloc.dart' as _i23;
import '../presentation/bloc/detail_list_bloc.dart' as _i25;
import '../presentation/bloc/detail_parametr_edit_bloc.dart' as _i7;
import '../presentation/bloc/detail_select_bloc.dart' as _i26;
import '../presentation/bloc/sheet_edit_bloc.dart' as _i28;
import '../presentation/bloc/sheet_list_bloc.dart' as _i30;
import '../presentation/bloc/sheet_select_bloc.dart'
    as _i31; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AppDataBase>(_i3.AppDataBase());
  gh.factory<_i4.CuttingBloc>(() => _i4.CuttingBloc());
  gh.singleton<_i5.DetailDataSource>(
      _i6.DetailDataSourceImpl(get<_i3.AppDataBase>()));
  gh.factoryParam<_i7.DetailParametrEditBloc, _i8.DetailParametr, dynamic>((
    initialparametr,
    _,
  ) =>
      _i7.DetailParametrEditBloc(initialparametr: initialparametr));
  gh.singleton<_i9.DetailRepository>(
      _i10.DetailrepositoryImpl(get<_i5.DetailDataSource>()));
  gh.singleton<_i11.InsertDetailParametrUseCase>(
      _i11.InsertDetailParametrUseCase(get<_i9.DetailRepository>()));
  gh.singleton<_i12.InsertDetailUseCase>(
      _i12.InsertDetailUseCase(get<_i9.DetailRepository>()));
  gh.singleton<_i13.SheetDataSource>(
      _i14.SheetDataSourceImpl(get<_i3.AppDataBase>()));
  gh.singleton<_i15.SheetRepository>(
      _i16.SheetRepositoryImpl(get<_i13.SheetDataSource>()));
  gh.singleton<_i17.WatchDetailParametrsUseCase>(
      _i17.WatchDetailParametrsUseCase(get<_i9.DetailRepository>()));
  gh.singleton<_i18.WatchDetailsUseCase>(
      _i18.WatchDetailsUseCase(get<_i9.DetailRepository>()));
  gh.singleton<_i19.WatchSheetsUseCase>(
      _i19.WatchSheetsUseCase(get<_i15.SheetRepository>()));
  gh.singleton<_i20.DeleteDetailParametrUseCase>(
      _i20.DeleteDetailParametrUseCase(get<_i9.DetailRepository>()));
  gh.singleton<_i21.DeleteDetailUseCase>(
      _i21.DeleteDetailUseCase(get<_i9.DetailRepository>()));
  gh.singleton<_i22.DeleteSheetUseCase>(
      _i22.DeleteSheetUseCase(get<_i15.SheetRepository>()));
  gh.factoryParam<_i23.DetailEditBloc, _i24.Detail, dynamic>((
    detail,
    _,
  ) =>
      _i23.DetailEditBloc(
        get<_i12.InsertDetailUseCase>(),
        get<_i21.DeleteDetailUseCase>(),
        get<_i17.WatchDetailParametrsUseCase>(),
        get<_i11.InsertDetailParametrUseCase>(),
        get<_i20.DeleteDetailParametrUseCase>(),
        detail: detail,
      ));
  gh.factory<_i25.DetailListBloc>(
      () => _i25.DetailListBloc(get<_i18.WatchDetailsUseCase>()));
  gh.factory<_i26.DetailSelectBloc>(
      () => _i26.DetailSelectBloc(get<_i18.WatchDetailsUseCase>()));
  gh.singleton<_i27.InsertSheetUseCase>(
      _i27.InsertSheetUseCase(get<_i15.SheetRepository>()));
  gh.factoryParam<_i28.SheetEditBloc, _i29.Sheet, dynamic>((
    sheet,
    _,
  ) =>
      _i28.SheetEditBloc(
        get<_i27.InsertSheetUseCase>(),
        get<_i22.DeleteSheetUseCase>(),
        sheet: sheet,
      ));
  gh.factory<_i30.SheetListBloc>(
      () => _i30.SheetListBloc(get<_i19.WatchSheetsUseCase>()));
  gh.factory<_i31.SheetSelectBloc>(
      () => _i31.SheetSelectBloc(get<_i19.WatchSheetsUseCase>()));
  return get;
}
