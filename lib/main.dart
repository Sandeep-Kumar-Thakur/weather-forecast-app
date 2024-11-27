import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forcast/application.dart';

import 'core/app_route.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Application.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(
            primary: Colors.black,
            secondary: Colors.white,
            seedColor: Colors.blue,
            brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.transparent,
            color: Colors.transparent
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
            primary: Colors.white,
            secondary: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: AppRoute.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
