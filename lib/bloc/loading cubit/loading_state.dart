part of 'loading_cubit.dart';

@immutable
abstract class LoadingState {}

class LoadingInitial extends LoadingState {
  LoadingInitial({required this.isLoaded, required this.isLoadedScreen});
  bool isLoaded;
  bool isLoadedScreen;
}
