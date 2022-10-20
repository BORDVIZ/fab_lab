import 'package:fab_lab/bloc/login%20cubit/login_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:fab_lab/pages/qr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return ModalProgressHUD(
            inAsyncCall: state.isLoaded,
            progressIndicator: const CircularProgressIndicator(
              color: Colors.purple,
            ),
            child: SafeArea(
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    const Text(
                      'F  A  B  L  A  B',
                      style: white40W200,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: CustomColors.gray,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 0.5,
                                offset: const Offset(0.0, 1.0),
                              ),
                            ]),
                        child: TextField(
                          onSubmitted: (value) {
                            BlocProvider.of<LoginCubit>(context)
                                .checkToken(value, context);
                          },
                          cursorColor: Colors.white,
                          cursorWidth: 1.5,
                          style: ttwhite16W500,
                          decoration: const InputDecoration(
                            fillColor: CustomColors.gray,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                            hintText: 'Введите свой токен',
                            hintStyle: white16W500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade900,
                              Colors.blue,
                              Colors.purple,
                            ])),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => QRPage(cont: context,)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.08),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Сканировать QR Code',
                                style: white16W500,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                'assets/icons/scanner.png',
                                width: 24,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
