import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/user%20cubit/user_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMainPage extends StatelessWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    sendPost(String name, String sex) async {
      if (textEditingController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Поле не может быть пустым')),
        );
        return;
      }
      int newsCount = 0;
      await FirebaseFirestore.instance
          .collection('news')
          .get()
          .then((QuerySnapshot querySnapshot) {
        newsCount = querySnapshot.docs.length;
      });
      await FirebaseFirestore.instance
          .collection('news')
          .doc('${newsCount + 1}')
          .set({'name': name, 'sex': sex, 'text': textEditingController.text});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Новость опубликована')),
      );
    }

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextField(
                      controller: textEditingController,
                      cursorColor: CustomColors.background,
                      style: ttblack16W400,
                      maxLines: 10,
                      decoration: const InputDecoration(
                          hintText: 'Новая новость',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                        sendPost(
                            state.userModel['name'], state.userModel['sex']);
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.08),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Опубликовать новую новость',
                        style: white16W500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
