import 'package:flutter/material.dart';
import 'package:teste_edusoft/censo/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Censo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.ranking,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}