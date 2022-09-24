part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial({required this.firstLaunch, required this.isLoaded});
  bool firstLaunch;
  bool isLoaded;
}
