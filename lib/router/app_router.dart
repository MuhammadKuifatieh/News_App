import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/pages/news_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case NewsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const NewsScreen(),
          settings: routeSettings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: routeSettings,
        );
    }
  }
}
