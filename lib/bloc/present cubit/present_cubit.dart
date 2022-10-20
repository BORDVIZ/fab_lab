import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'present_state.dart';

class PresentCubit extends Cubit<PresentState> {
  PresentCubit() : super(PresentInitial(students: const [], present: const []));

  getStudents(context) async {
    try {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String name = preferences.getString('name')!;
      List<Map<String, dynamic>> l = [];
      List<Map<String, dynamic>> lP = [];
      Map<String, dynamic> map;
      Map<String, dynamic> mapPresent;
      await FirebaseFirestore.instance
          .collection('students')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['teacher'] == name) {
            map = {
              'name': doc['name'],
              'teacher': doc['teacher'],
              'students': doc['students']
            };
            List stud = doc['students'];
            List pStud = [];
            for (int i = 0; i < stud.length; i++) {
              Map<String, dynamic> st = {
                'name': stud[i]['name'],
                'present': false
              };
              pStud.add(st);
            }
            mapPresent = {'name': doc['name'], 'students': pStud};
            l.add(map);
            lP.add(mapPresent);
          }
        }
        emit(PresentInitial(students: l, present: lP));
      });
    } catch (e) {
      print(e.toString());
    } finally {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(false);
    }
  }

  addPresent(List<Map<String, dynamic>> students, List<Map<String, dynamic>> oldList, int firstIndex,
      int secondIndex, bool value) {
    try {
      oldList[firstIndex]['students'][secondIndex]['present'] = !value;
      emit(PresentInitial(students: students, present: oldList));
    } catch (e) {
      print(e.toString());
    }
  }

  getAllStudents(context) async {
    try {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(true);
      List<Map<String, dynamic>> l = [];
      Map<String, dynamic> map;
      Map<String, dynamic> mapPresent;
      await FirebaseFirestore.instance
          .collection('students')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
            map = {
              'name': doc['name'],
              'teacher': doc['teacher'],
              'students': doc['students']
            };
            List stud = doc['students'];
            List pStud = [];
            for (int i = 0; i < stud.length; i++) {
              Map<String, dynamic> st = {
                'name': stud[i]['name'],
                'present': false
              };
              pStud.add(st);
            }
            mapPresent = {'name': doc['name'], 'students': pStud};
            l.add(map);
        }
        emit(PresentInitial(students: l, present: const []));
      });
    } catch (e) {
      print(e.toString());
    } finally {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(false);
    }
  }

}
