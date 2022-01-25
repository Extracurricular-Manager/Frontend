import 'package:flutter/material.dart';
import 'package:frontendmobile/views/home_view.dart';
import 'package:frontendmobile/views/login_view.dart';
import 'package:frontendmobile/views/student_view.dart';

class RouteGenerator {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/login_view':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home_view':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/student_view':
        return MaterialPageRoute(builder: (_) => const StudentView());
      default:
        return MaterialPageRoute(builder: (_) => const HomeView());
    }
  }
}
