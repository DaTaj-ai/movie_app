import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/theme/theme.dart';
import 'package:movie_app/features/movies/presentation/pages/main_layout.dart';
import 'package:provider/provider.dart';

import '../../features/movies/domain/usecases/get_movies.dart';
import '../../features/movies/presentation/cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../../features/movies/presentation/cubit/movie_list_cubit/movie_list_cubit.dart';
import '../../features/movies/presentation/cubit/trending_movie_cubit/trending_movie_cubit.dart';
import '../di/di.dart' as di;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<GetMovies>(
      create: (_) => di.sl<GetMovies>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavBarCubit>(
            create: (context) => di.sl<BottomNavBarCubit>(),
          ),
          BlocProvider<TrendingCubit>(
            create: (context) => di.sl<TrendingCubit>()..fetchTrending(),
          ),
          BlocProvider<MovieListCubit>(
            create: (context) => di.sl<MovieListCubit>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const MainLayout(),
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }
}