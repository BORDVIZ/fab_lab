import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddUserInitial(isLoaded: false, users: const []));

  getAllUsers() async {
    try {
      emit(AddUserInitial(isLoaded: true, users: const []));
      List users = [];
      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (!doc['isAdmin']) {
            users.add(doc);
          }
        }
        emit(AddUserInitial(isLoaded: false, users: users));
      });
    } catch (e) {
      print(e.toString());
      emit(AddUserInitial(isLoaded: false, users: const []));
    }
  }
}
