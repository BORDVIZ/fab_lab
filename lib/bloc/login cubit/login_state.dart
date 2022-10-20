part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  LoginInitial({required this.isLoaded});
  bool isLoaded;
}
