import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/adaptivity/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_list/ui/pages/welcome_screen.dart';
import 'package:to_do_list/adaptivity/font_sizes.dart';
import 'package:to_do_list/managers/bloc/todo_bloc.dart';
import 'dart:io' show Platform;
import 'package:to_do_list/managers/navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void main() => runApp(const MaterialApp(
      home: App(),
    ));

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const home = WelcomePage();
    if (Platform.isIOS) {
      return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => TileListBloc())],
          child: const CupertinoApp(
            theme: CupertinoThemeData(
              scaffoldBackgroundColor: backLight,
            ),
            home: home,
          ));
    } else {
      return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => TileListBloc())],
          child: MaterialApp(
            supportedLocales: const [
              Locale('en'),
              Locale('ru'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              scaffoldBackgroundColor: backLight,
              textTheme: const TextTheme(
                headlineLarge: TextStyle(fontSize: largeTitle, color: mainText),
                headlineMedium: TextStyle(fontSize: midTitle, color: mainText),
                bodyMedium: TextStyle(fontSize: button, color: secondaryText),
                bodySmall: TextStyle(fontSize: body, color: secondaryText),
              ),
            ),
            home: home,
            navigatorKey: NavigationManager.instance.key,
          ));
    }
  }
}
