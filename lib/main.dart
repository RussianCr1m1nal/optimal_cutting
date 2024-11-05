import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:optimal_cutting/common/theme/app_theme.dart';
import 'package:optimal_cutting/di/di.dart';
import 'package:optimal_cutting/domain/detail/entity/detail.dart';
import 'package:optimal_cutting/domain/sheet/entity/sheet.dart';
import 'package:optimal_cutting/presentation/bloc/cutting_bloc.dart';
import 'package:optimal_cutting/presentation/screen/cutting/cutting_screen.dart';
import 'package:optimal_cutting/presentation/screen/detail/detail_list_screen.dart';
import 'package:optimal_cutting/presentation/screen/sheet/sheet_edit_screen.dart';
import 'package:optimal_cutting/presentation/screen/sheet/sheet_list_screen.dart';
import 'package:optimal_cutting/presentation/screen/sheet/sheet_select_screen.dart';
import 'package:optimal_cutting/presentation/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'presentation/screen/detail/detail_edit_screen.dart';
import 'presentation/screen/detail/detail_select_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await configureDependencies(Environment.dev);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: SplashScreen.routeName,
      routes: <RouteBase>[
        GoRoute(
          path: SplashScreen.routeName,
          pageBuilder: (context, state) => const CupertinoPage(
            child: SplashScreen(),
          ),
        ),
        GoRoute(
          path: CuttingScreen.routeName,
          pageBuilder: (context, state) => const CupertinoPage(
            child: CuttingScreen(),
          ),
        ),
        GoRoute(
          path: DetailListScreen.routeName,
          pageBuilder: (context, state) => const CupertinoPage(
            child: DetailListScreen(),
          ),
        ),
        GoRoute(
          path: SheetListScreen.routeName,
          pageBuilder: (context, state) => const CupertinoPage(
            child: SheetListScreen(),
          ),
        ),
        GoRoute(
          path: SheetEditScreen.routeName,
          pageBuilder: (context, state) => CupertinoPage(
            child: SheetEditScreen(
              sheet: (state.extra as Sheet),
            ),
          ),
        ),
        GoRoute(
          path: DetailEditScreen.routeName,
          pageBuilder: (context, state) => CupertinoPage(
            child: DetailEditScreen(
              detail: (state.extra as Detail),
            ),
          ),
        ),
        GoRoute(
          path: SheetSelectScreen.routeName,
          pageBuilder: (context, state) => const CupertinoPage(
            child: SheetSelectScreen(),
          ),
        ),
        GoRoute(
          path: DetailSelectScreen.routeName,
          pageBuilder: (context, state) => const CupertinoPage(
            child: DetailSelectScreen(),
          ),
        ),
      ],
    );

    return Provider<CuttingBloc>(
      create: (context) => getIt<CuttingBloc>(),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Optimal cutting',
        theme: AppTheme.defaults(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
