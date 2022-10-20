import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:fab_lab/bloc/user%20cubit/user_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  sendNews(context, name, sex, text) async {
    try {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(true);
      await FirebaseFirestore.instance
          .collection('news')
          .add({'name': name, 'sex': sex, 'text': text});
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Новость отправлена')),
      );
    } catch (e) {
      print(e.toString());
    } finally {
      BlocProvider.of<LoadingCubit>(context).changeValueScreen(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController();
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 200,
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
                    maxLines: 10,
                    cursorColor: Colors.white,
                    cursorWidth: 1.5,
                    controller: controller,
                    style: ttwhite16W500,
                    decoration: const InputDecoration(
                      fillColor: CustomColors.gray,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Новая новость',
                      hintStyle: white16W500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: w,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    sendNews(context, state.userModel['name'],
                        state.userModel['sex'], controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Отправить новость',
                          style: ttwhite16W500,
                        ),
                        Image.asset(
                          'assets/icons/send.png',
                          width: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
