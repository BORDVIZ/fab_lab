part of 'add_subject_cubit.dart';

@immutable
abstract class AddSubjectState {}

class AddSubjectInitial extends AddSubjectState {
  AddSubjectInitial({required this.subjects, required this.isLoaded});

  List subjects;
  bool isLoaded;
}
