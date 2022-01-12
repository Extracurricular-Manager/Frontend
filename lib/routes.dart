import 'package:flutter/material.dart';
import 'package:frontendmobile/views/pageeleve.dart';

class RouteGenerator {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const PageEleve(
                  title: '',
                ));
      case '/pageeleve':
        return MaterialPageRoute(
            builder: (_) => const PageEleve(
                  title: '',
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const PageEleve(
                  title: '',
                ));
    }
  }
}
