import 'package:flutter/material.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/presentation/page/news.dart';
import 'constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => NewsPage());
      default:
        return MaterialPageRoute(builder: (_) => NewsPage());
    }
  }
}
