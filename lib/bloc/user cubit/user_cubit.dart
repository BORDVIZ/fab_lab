import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:fab_lab/bloc/news%20cubit/news_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial(userModel: const {}));

  getUserModel(context) async {
    try {
      BlocProvider.of<LoadingCubit>(context).changeValue(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String token = preferences.getString('token')!;
      Map<String, dynamic> map;
      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc['token'] == token) {
            map = {
              'name': doc['name'],
              'token': doc['token'],
              'isAdmin': doc['isAdmin'],
              'sex': doc['sex'],
            };
            preferences.setString('name', doc['name']);
            emit(UserInitial(userModel: map));
            BlocProvider.of<NewsCubit>(context).getNews();
          }
        }
      });
    } catch (e) {
      print(e.toString());
      emit(UserInitial(userModel: const {}));
    }finally{
      BlocProvider.of<LoadingCubit>(context).changeValue(false);
    }
  }
}
