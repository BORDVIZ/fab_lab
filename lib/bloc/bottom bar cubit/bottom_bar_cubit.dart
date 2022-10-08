import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarInitial(page: 0));

  changePage(int page) {
    emit(BottomBarInitial(page: page));
  }
}
