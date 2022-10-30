part of 'present_stat_cubit.dart';

@immutable
abstract class PresentStatState {}

class PresentStatInitial extends PresentStatState {
  PresentStatInitial({required this.presentStat, required this.isLoaded});

  List presentStat;
  bool isLoaded;
}
