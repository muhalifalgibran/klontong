import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klontong/app.dart';
import 'package:klontong/core/di/service_locator.dart';

void main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klontong App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const App(),
    );
  }
}
