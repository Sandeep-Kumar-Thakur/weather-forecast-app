import 'package:flutter/material.dart';
import 'package:weather_forcast/features/home/view/home_page.dart';
import 'package:weather_forcast/features/search/view/search_page.dart';
import 'package:weather_forcast/features/splash/view/splash_page.dart';

class AppRoute {
  static const splash = '/';
  static const home = '/home';
  static const search = '/search';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return buildRoute(const SplashPage(), settings: settings);
      case AppRoute.home:
        return buildRoute(
          const HomePage(),
          settings: settings,
        );
      case AppRoute.search:
        return buildRoute(
          const SearchPage(),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static PageRouteBuilder buildRoute(Widget child,
      {required RouteSettings settings}) {
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => child,
        transitionDuration: const Duration(seconds: 1));
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
