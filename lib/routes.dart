import 'package:flutter/material.dart';
import 'package:frontendmobile/views/canteen_view.dart';
import 'package:frontendmobile/views/day_nursery_view.dart';
import 'package:frontendmobile/views/home_view.dart';
import 'package:frontendmobile/views/login_view.dart';
import 'package:frontendmobile/views/login_view_dynamic.dart';
import 'package:frontendmobile/views/night_nursery_view.dart';
import 'package:frontendmobile/views/student_view.dart';

class RouteGenerator {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginViewDynamic());
      case '/login_view':
        return MaterialPageRoute(builder: (_) => const LoginViewDynamic());
      case '/home_view':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/student_view':
        return MaterialPageRoute(builder: (_) => const StudentView());
      case '/canteen_view':
        return MaterialPageRoute(builder: (_) => const CanteenView());
      case '/night_nusery_view':
        return MaterialPageRoute(builder: (_) => const NightNurseryView());
      case '/day_nursery_view':
        return MaterialPageRoute(builder: (_) => const DayNurseryView());
      default:
        return MaterialPageRoute(builder: (_) => const HomeView());
    }
  }
}
