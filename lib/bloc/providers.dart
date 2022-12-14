import 'package:fab_lab/bloc/auth%20cubit/auth_cubit.dart';
import 'package:fab_lab/bloc/bottom%20bar%20cubit/bottom_bar_cubit.dart';
import 'package:fab_lab/bloc/calendar%20cubit/calendar_cubit.dart';
import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:fab_lab/bloc/login%20cubit/login_cubit.dart';
import 'package:fab_lab/bloc/news%20cubit/news_cubit.dart';
import 'package:fab_lab/bloc/present%20cubit/present_cubit.dart';
import 'package:fab_lab/bloc/user%20cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<AuthCubit>(create: (_) => AuthCubit(),),
    BlocProvider<BottomBarCubit>(create: (_) => BottomBarCubit(),),
    BlocProvider<LoginCubit>(create: (_) => LoginCubit(),),
    BlocProvider<UserCubit>(create: (_)=> UserCubit(),),
    BlocProvider<NewsCubit>(create: (_)=> NewsCubit(),),
    BlocProvider<LoadingCubit>(create: (_)=> LoadingCubit(),),
    BlocProvider<PresentCubit>(create: (_)=> PresentCubit(),),
    BlocProvider<CalendarCubit>(create: (_)=> CalendarCubit(),),
  ];
}
