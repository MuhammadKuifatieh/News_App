import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/pages/news_screen.dart';
import 'package:news_app/router/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: NewsScreen.routeName,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
