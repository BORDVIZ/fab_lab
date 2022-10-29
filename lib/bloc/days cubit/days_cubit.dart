import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'days_state.dart';

class DaysCubit extends Cubit<DaysState> {
  DaysCubit() : super(DaysInitial(days: const []));

  clearAll() {
    emit(DaysInitial(
        days: const [false, false, false, false, false, false, false]));
  }

  addDay(days, index) {
    List l = [];
    l.addAll(days);
    bool val = l[index];
    l[index] = !val;
    emit(DaysInitial(days: l));
  }
}
