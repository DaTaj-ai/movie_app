import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_navigation_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState(0));

  void changeTab(int index) => emit(BottomNavBarState(index));
}
