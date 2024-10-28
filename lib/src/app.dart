import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:realtime_innovation_manage_employees/src/repository/employee_repository.dart';

import 'adding_an_employee/add_employee_view.dart';
import 'employee_listing/employees_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EmployeeRepository(),
      child: MaterialApp(
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blueAccent,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18))),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<bool?>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case AddEmployeeView.routeName:
                  return const AddEmployeeView();
                case SampleItemListView.routeName:
                default:
                  return const SampleItemListView();
              }
            },
          );
        },
      ),
    );
  }
}
