import 'package:fab_lab/bloc/auth%20cubit/auth_cubit.dart';
import 'package:fab_lab/view/login_view.dart';
import 'package:fab_lab/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: ModalProgressHUD(
                  inAsyncCall: state.isLoaded,
                  color: Colors.black,
                  progressIndicator: const CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.transparent,
                  ),
                  child:
                      state.firstLaunch ? const MainView() : const LoginView()),
              // child: const MainView()),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
