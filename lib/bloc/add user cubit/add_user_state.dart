part of 'add_user_cubit.dart';

@immutable
abstract class AddUserState {}

class AddUserInitial extends AddUserState {
  AddUserInitial({required this.isLoaded, required this.users});

  bool isLoaded;
  List users;
}
