import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial(isLoaded: false, isLoadedScreen: false));


  changeValue(bool value) {
    emit(LoadingInitial(isLoaded: value, isLoadedScreen: false));
  }

  changeValueScreen(bool value) {
    emit(LoadingInitial(isLoaded: false, isLoadedScreen: value));
  }
}
