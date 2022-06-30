import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timezone_app/constants.dart';
import 'package:flutter_timezone_app/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Hive.initFlutter();
  await Hive.openBox('darkMode');
  await Hive.openBox('selectedCity');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('darkMode').listenable(),
        builder: (context, Box box, widget) {
          return MaterialApp(
            localizationsDelegates: [GlobalMaterialLocalizations.delegate],
            supportedLocales: [const Locale('en'), const Locale('tr')],
            debugShowCheckedModeBanner: false,
            title: 'Timezone App',
            themeMode: box.get('themeMode', defaultValue: false)
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData.light().copyWith(
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: kTextColor),
                  centerTitle: true,
                  color: Colors.white),
            ),
            darkTheme: ThemeData.dark().copyWith(
                appBarTheme: AppBarTheme(centerTitle: true, color: kTextColor),
                scaffoldBackgroundColor: kTextColor,
                cardColor: kdarkColor),
            home: SplashScreen(),
          );
        });
  }
}
