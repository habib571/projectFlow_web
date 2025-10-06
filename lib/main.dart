import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/routes/app_routes.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/utils/app_context.dart';
import 'package:projectflow_web/presentation/utils/screen_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenUtility = ScreenConfiguration();

    screenUtility.initialize(context);
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'Project Flow',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffold,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary500),
        useMaterial3: true,

      ),
      builder: (context, child) {
        final appContext = getIt.get<AppContext>();
        appContext.setContext(context);
        return child!;
      },

    );
  }
}
