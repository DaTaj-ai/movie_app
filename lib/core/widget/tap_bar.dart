import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ReusableTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final void Function(int) onTap;
  final Color indicatorColor;
  final TextStyle? textStyle;
  final Color selectedColor;
  final Color unselectedColor;
  final FontWeight selectedFontWeight;
  final FontWeight unselectedFontWeight;
  final double indicatorHeight;
  final double indicatorRadius;
  final double horizontal_padding ;

  const ReusableTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    required this.indicatorColor ,
    this.textStyle,
    this.selectedColor = Colors.white,
    this.unselectedColor = Colors.grey,
    this.selectedFontWeight = FontWeight.bold,
    this.unselectedFontWeight = FontWeight.normal,
    this.indicatorHeight = 2,
    this.indicatorRadius = 1,
    this.horizontal_padding = 22,
  });

  double _textWidth(String text, TextStyle style, BuildContext context) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.textScaleFactorOf(context),
    )..layout();
    return tp.width;
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = textStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;

          final style = baseStyle.copyWith(
            color: isSelected ? selectedColor : unselectedColor,
            fontWeight: isSelected ? selectedFontWeight : unselectedFontWeight,
          );

          final indicatorWidth =
          isSelected ? _textWidth(tabs[index], style, context) : 0.0;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal_padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tabs[index], style: style),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: indicatorHeight,
                    width: indicatorWidth,
                    decoration: BoxDecoration(
                      color: indicatorColor,
                      borderRadius: BorderRadius.circular(indicatorRadius),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
