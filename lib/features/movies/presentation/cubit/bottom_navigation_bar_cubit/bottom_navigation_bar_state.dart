import 'package:equatable/equatable.dart';

class BottomNavBarState extends Equatable {
  final int currentIndex;

  const BottomNavBarState(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}