part of 'present_cubit.dart';

@immutable
abstract class PresentState {}

class PresentInitial extends PresentState {
  PresentInitial({required this.students, required this.present});
  List<Map<String, dynamic>> students;
  List<Map<String, dynamic>> present;
}
