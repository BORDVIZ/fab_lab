import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'present_stat_state.dart';

class PresentStatCubit extends Cubit<PresentStatState> {
  PresentStatCubit()
      : super(PresentStatInitial(presentStat: const [], isLoaded: false));

  getPresentList() async {
    emit(PresentStatInitial(presentStat: const [], isLoaded: true));
    List l = [];
    await FirebaseFirestore.instance
        .collection('present')
        .get()
        .then((QuerySnapshot query) {
      for (var doc in query.docs) {
        l.add(doc);
      }
    });
    emit(PresentStatInitial(presentStat: l, isLoaded: false));
  }
}
