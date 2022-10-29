part of 'days_cubit.dart';

@immutable
abstract class DaysState {}

class DaysInitial extends DaysState {
  DaysInitial({required this.days});

  List days;
}
