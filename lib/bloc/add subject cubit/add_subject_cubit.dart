import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_subject_state.dart';

class AddSubjectCubit extends Cubit<AddSubjectState> {
  AddSubjectCubit()
      : super(AddSubjectInitial(subjects: const [], isLoaded: false));

  getAllSubjects() async {
    try {
      emit(AddSubjectInitial(subjects: const [], isLoaded: true));
      List l = [];
      await FirebaseFirestore.instance
          .collection('students')
          .get()
          .then((QuerySnapshot query) {
        for (var doc in query.docs) {
          l.add(doc);
        }
      });
      emit(AddSubjectInitial(subjects: l, isLoaded: false));
    } catch (e) {
      print(e.toString());
      emit(AddSubjectInitial(subjects: const [], isLoaded: false));
    }
  }
}
