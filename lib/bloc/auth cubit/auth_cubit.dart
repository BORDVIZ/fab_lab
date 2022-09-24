import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial(firstLaunch: false, isLoaded: false));

  void checkToken() async {
    emit(AuthInitial(firstLaunch: false, isLoaded: true));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final firstLaunch = preferences.getString('token');
    if (firstLaunch == null) {
      emit(AuthInitial(firstLaunch: false, isLoaded: false));
    } else {
      emit(AuthInitial(firstLaunch: true, isLoaded: false));
    }
  }
}
