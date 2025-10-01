import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/app_colors.dart';
import '../../../../core/widget/reusable_tab_bar.dart';
import '../cubit/movie_list_cubit/movie_list_cubit.dart';
import '../cubit/movie_list_cubit/movie_list_state.dart';
import '../widgets/movie_grid.dart';
import '../widgets/movie_row.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // provide the cubit
      create: (_) => MovieListCubit(context.read())..fetchInitial(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Container(
                padding: const EdgeInsets.only(top: 26, left: 24),
                child: Text(
                  'What do you want to watch?',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),

              CustomSearchBar(
                controller: TextEditingController(),
                onChanged: (value) {},
              ),
              AutoImageCarousel(
                height: 210,
                width: 144.6,
              ),
              SizedBox(height: 12.0),

              BlocBuilder<MovieListCubit, MovieListState>(
                builder: (context, state) {
                  final cubit = context.read<MovieListCubit>();

                  return ReusableTabBar(
                    tabs: const [
                      "Now Playing",
                      "Upcoming",
                      "Top Rated",
                      "Popular",
                    ],
                    selectedIndex: state.selectedIndex,
                    onTap: (index) {
                      cubit.changeTab(index);
                    }, indicatorColor: AppColors.grayFocus,

                  );
                },
              ),

              BlocBuilder<MovieListCubit, MovieListState>(
                builder: (context, state) {
                  if (state.isLoading && state.movies.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state.error != null) {
                    print("Error: ${state.error}");
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text("Error: ${state.error}"),
                      ),
                    );
                  }

                  if (state.movies.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text("No movies found"),
                      ),
                    );
                  }

                  return ImageGrid(movies: state.movies);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


