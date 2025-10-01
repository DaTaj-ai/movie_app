import 'package:flutter/material.dart';
import 'package:movie_app/config/route/routes.dart';

import '../../features/movies/presentation/pages/home.dart';
import '../../features/movies/presentation/pages/main_layout.dart';
import '../../features/movies/presentation/pages/search.dart';
import '../../features/movies/presentation/pages/watch_list.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainLayout:
        return MaterialPageRoute(builder: (context) => const MainLayout());
      case AppRoutes.home :
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AppRoutes.watch_list:
        return MaterialPageRoute(builder: (context) => const WatchListScreen());
      case AppRoutes.search :
        return MaterialPageRoute(builder: (context) => const SearchScreen());
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

