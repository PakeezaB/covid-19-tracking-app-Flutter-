import 'package:covid_19_tracking_app/screens/homescreen.dart';
import 'package:covid_19_tracking_app/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyMedium:
              GoogleFonts.lato(textStyle: const TextStyle(fontSize: 14)),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 60, 160, 65),
          titleTextStyle:
              GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20)),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
