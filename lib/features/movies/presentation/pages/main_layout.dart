import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/app_colors.dart';
import 'package:movie_app/features/movies/presentation/pages/home.dart';
import 'package:movie_app/features/movies/presentation/pages/search.dart';
import 'package:movie_app/features/movies/presentation/pages/watch_list.dart';

import '../../../../core/widget/bottom_navigation_bar.dart';
import '../cubit/buttom_navigation_bar_cubit/bnb_cubit.dart';
import '../cubit/buttom_navigation_bar_cubit/bub_state.dart';


class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeScreen(),
      SearchScreen(),
      WatchListScreen(),
    ];

    return BlocBuilder<NavCubit, NavState>(
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
            onTap: (i) => context.read<NavCubit>().changeTab(i),
          ),
        );
      },
    );
  }
}
