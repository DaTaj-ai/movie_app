import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/Home.png",
            width: 21.74,
            height: 24,
            color: AppColors.textSecondary,
          ),
          activeIcon: Image.asset(
            "assets/icons/Home.png",
            width: 24,
            height: 24,
            color: AppColors.myBlue,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/Search.png",
            width: 21.74,
            height: 24,
            color: AppColors.textSecondary,
          ),
          activeIcon: Image.asset(
            "assets/icons/Search.png",
            width: 24,
            height: 24,
            color: AppColors.myBlue,
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/Bookmark.png",
            width: 21.74,
            height: 24,
            color: AppColors.textSecondary,
          ),
          activeIcon: Image.asset(
            "assets/icons/Bookmark.png",
            width: 24,
            height: 24,
            color: AppColors.myBlue,
          ),
          label: "Watchlist",
        ),
      ],
    );
  }
}
