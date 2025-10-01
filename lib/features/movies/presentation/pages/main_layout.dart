import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/features/movies/presentation/pages/home.dart';
import 'package:movie_app/features/movies/presentation/pages/search.dart';
import 'package:movie_app/features/movies/presentation/pages/watch_list.dart';
import '../../../../core/widget/bottom_navigation_bar.dart';
import '../cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_state.dart';


class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeScreen(),
      SearchScreen(),
      WatchListScreen(),
    ];

    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
        backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: IndexedStack(
              index: state.currentIndex,
              children: pages,
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (i) => context.read<BottomNavBarCubit>().changeTab(i),
          ),
        );
      },
    );
  }
}
