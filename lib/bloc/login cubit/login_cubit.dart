import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:fab_lab/pages/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial(isLoaded: false));

  checkToken(String token, context) async {
    try {
      emit(LoginInitial(
        isLoaded: true,
      ));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        bool isLogin = false;
        for (var doc in querySnapshot.docs) {
          if (doc['token'] == token) {
            final firstLaunch = preferences.setString('token', token);
            isLogin = true;
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const InitialPage()));
          }
        }
        if (!isLogin) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Неверный токен',
              style: ttwhite16W500,
            )),
          );
        }
      });
    } catch (e) {
      print(e.toString());
    } finally {
      emit(LoginInitial(
        isLoaded: false,
      ));
    }
  }
}
