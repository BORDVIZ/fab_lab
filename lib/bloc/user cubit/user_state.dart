part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {
  UserInitial({ required this.userModel});
  Map<String, dynamic> userModel;
}
