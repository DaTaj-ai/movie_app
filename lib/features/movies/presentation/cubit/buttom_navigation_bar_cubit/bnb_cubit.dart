import 'package:flutter_bloc/flutter_bloc.dart';
import 'bub_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavState(0));

  void changeTab(int index) => emit(NavState(index));
}
