import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_state.dart';


class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top:  24.0 , left: 24.0 , right: 24.0),
        child: SizedBox(
          height: 42,
          child: SearchBar(
            controller: controller,
            onChanged: onChanged,
            hintText: "Search",
            trailing: [
              IconButton(
                icon: Icon(Icons.search, color: AppColors.grayLight ),
                onPressed: () {
                  context.read<BottomNavBarCubit>().changeTab(1);
                },
              ),
            ],
            backgroundColor: WidgetStateProperty.all(AppColors.grayFocus),
            textStyle: WidgetStateProperty.all(
              Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
            ),
            hintStyle: WidgetStateProperty.all(
              Theme.of(context).textTheme.bodyLarge?.copyWith(color:AppColors.grayLight ),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        )
      );
          }
    );
  }
}
