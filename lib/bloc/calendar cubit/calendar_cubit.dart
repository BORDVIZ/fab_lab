import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial(days: const []));

  getDays(context) async {
    try {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String name = preferences.getString('name')!;
      await FirebaseFirestore.instance
          .collection('days')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['name'] == name) {
            final List d = doc['days'];
            List l = [];
            for (int i = 0; i < d.length; i++) {
              String day = d[i];
              print(day);
              switch (day) {
                case 'Mon':
                  l.add(DateTime.monday);
                  continue;
                case 'Tue':
                  l.add(DateTime.tuesday);
                  continue;
                case 'Wed':
                  l.add(DateTime.wednesday);
                  continue;
                case 'Tru':
                  l.add(DateTime.thursday);
                  continue;
                case 'Fri':
                  l.add(DateTime.friday);
                  continue;
                case 'Sat':
                  l.add(DateTime.saturday);
                  continue;
                case 'Sun':
                  l.add(DateTime.sunday);
                  continue;
              }
            }
            emit(CalendarInitial(days: l));
          }
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(false);
    }
  }
}
