import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/add%20subject%20cubit/add_subject_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddSubject extends StatefulWidget {
  const AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  @override
  void initState() {
    BlocProvider.of<AddSubjectCubit>(context).getAllSubjects();
    super.initState();
  }

  addSubject(name, teacher) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(name)
        .set({'name': name, 'teacher': teacher});
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Предмет добавлен')),
    );
    BlocProvider.of<AddSubjectCubit>(context).getAllSubjects();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController teacherController = TextEditingController();
    return BlocBuilder<AddSubjectCubit, AddSubjectState>(
      builder: (context, state) {
        if (state is AddSubjectInitial) {
          return ModalProgressHUD(
            inAsyncCall: state.isLoaded,
            color: Colors.black,
            progressIndicator: const CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.transparent,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Добавить предмет'),
                backgroundColor: CustomColors.background,
              ),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: CustomColors.light,
                  child: const Icon(
                    Icons.add,
                    color: CustomColors.background,
                  ),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: CustomColors.gray),
                                      child: TextField(
                                        controller: nameController,
                                        cursorColor: CustomColors.background,
                                        style: ttwhite16W500,
                                        decoration: const InputDecoration(
                                            hintText: 'Название',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: CustomColors.gray),
                                      child: TextField(
                                        controller: teacherController,
                                        cursorColor: CustomColors.background,
                                        style: ttwhite16W500,
                                        decoration: const InputDecoration(
                                            hintText: 'Преподаватель',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          gradient: LinearGradient(colors: [
                                            Colors.purple.shade900,
                                            Colors.blue,
                                            Colors.purple,
                                          ])),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (nameController.text != '' &&
                                              teacherController.text != '') {
                                            addSubject(nameController.text,
                                                teacherController.text);
                                          } else {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Поле не может быть пустым')),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.white.withOpacity(0.08),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Text(
                                          'Добавить предмет',
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
                  }),
              body: SizedBox(
                width: double.infinity,
                child: SafeArea(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.subjects.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                gradient:
                                    const RadialGradient(radius: 5, colors: [
                                  Color.fromARGB(255, 63, 50, 157),
                                  Color.fromARGB(255, 160, 10, 177),
                                  Colors.blue,
                                ]),
                                border:
                                    Border.all(color: Colors.white, width: 0.2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      gradient:
                                          RadialGradient(radius: 3, colors: [
                                        Colors.grey.shade900.withOpacity(0.5),
                                        Colors.grey.shade300.withOpacity(0.3),
                                        Colors.white.withOpacity(0.3),
                                      ]),
                                      border: Border.all(
                                          color: Colors.white, width: 0.2),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            CustomColors.background,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Image.asset(
                                            'assets/images/fab_lab.png',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: CustomColors.background
                                                    .withOpacity(0.25)),
                                            child: Text(
                                              state.subjects[index]['name'],
                                              style: ttwhite16W500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
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
