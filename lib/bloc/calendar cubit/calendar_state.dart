part of 'calendar_cubit.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {
  CalendarInitial({required this.days});
  List days;
}
