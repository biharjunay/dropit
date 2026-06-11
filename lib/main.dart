import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/daftar_screen.dart';
import 'screens/details_screen.dart';
import 'screens/petunjuk_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drop It AR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C60C0),
          primary: const Color(0xFF2C60C0),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/daftar': (context) => const DaftarScreen(),
        '/details': (context) => const DetailsScreen(),
        '/petunjuk': (context) => const PetunjukScreen(),
      },
    );
  }
}
