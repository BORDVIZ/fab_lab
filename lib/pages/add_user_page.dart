import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/add%20user%20cubit/add_user_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  void initState() {
    BlocProvider.of<AddUserCubit>(context).getAllUsers();
    super.initState();
  }

  addNewUser(String name, String sex, String isAdmin, String token) async {
    if (sex.toLowerCase() == 'муж' || sex.toLowerCase() == 'жен') {
      if (isAdmin.toLowerCase() == 'да' || isAdmin.toLowerCase() == 'нет') {
        await FirebaseFirestore.instance.collection('users').doc(name).set({
          'name': name,
          'sex': sex.toLowerCase() == 'муж' ? 'male' : 'female',
          'isAdmin': isAdmin.toLowerCase() == 'да' ? true : false,
          'token': token
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пользователь добавлен')),
        );
        BlocProvider.of<AddUserCubit>(context).getAllUsers();
        return;
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Поле Админ введено неверно(да/нет)')),
        );
        return;
      }
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пол введен неверно(муж/жен)')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController sexController = TextEditingController();
    TextEditingController isAdminController = TextEditingController();
    TextEditingController tokenController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (_) {
                return Container(
                  height: 600,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.gray),
                            child: TextField(
                              controller: nameController,
                              cursorColor: CustomColors.background,
                              style: ttwhite16W500,
                              decoration: const InputDecoration(
                                  hintText: 'Имя Фамилия',
                                  hintStyle: ttwhite16W500,
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.gray),
                            child: TextField(
                              controller: sexController,
                              cursorColor: CustomColors.background,
                              style: ttwhite16W500,
                              decoration: const InputDecoration(
                                  hintText: 'Пол (муж/жен)',
                                  hintStyle: ttwhite16W500,
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.gray),
                            child: TextField(
                              controller: isAdminController,
                              cursorColor: CustomColors.background,
                              style: ttwhite16W500,
                              decoration: const InputDecoration(
                                  hintText: 'Админ (да/нет)',
                                  hintStyle: ttwhite16W500,
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.gray),
                            child: TextField(
                              controller: tokenController,
                              cursorColor: CustomColors.background,
                              style: ttwhite16W500,
                              decoration: const InputDecoration(
                                  hintText: 'Токен',
                                  hintStyle: ttwhite16W500,
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none),
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
                                if (nameController.text != '' &&
                                    sexController.text != '' &&
                                    isAdminController.text != '' &&
                                    tokenController.text != '') {
                                  addNewUser(
                                      nameController.text,
                                      sexController.text,
                                      isAdminController.text,
                                      tokenController.text);
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Поле не может быть пустым')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.08),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Добавить пользователя',
                                style: white16W500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        backgroundColor: CustomColors.light,
        child: const Icon(
          Icons.add,
          color: CustomColors.background,
        ),
      ),
      appBar: AppBar(
        title: const Text('Добавить пользователя'),
        backgroundColor: CustomColors.background,
      ),
      body: SizedBox(
        width: double.infinity,
        child: BlocBuilder<AddUserCubit, AddUserState>(
          builder: (context, state) {
            if (state is AddUserInitial) {
              return ModalProgressHUD(
                inAsyncCall: state.isLoaded,
                color: Colors.black,
                progressIndicator: const CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.users[index]['name'],
                                style: ttblack16W400,
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: CustomColors.gray,
                                child: state.users[index]['sex'] == 'male'
                                    ? Image.asset('assets/images/male.png')
                                    : Image.asset('assets/images/female.png'),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
