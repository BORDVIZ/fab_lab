import 'package:fab_lab/bloc/auth%20cubit/auth_cubit.dart';
import 'package:fab_lab/bloc/bottom%20bar%20cubit/bottom_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<AuthCubit>(create: (_) => AuthCubit(),),
    BlocProvider<BottomBarCubit>(create: (_) => BottomBarCubit(),),
  ];
}
