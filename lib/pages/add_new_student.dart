import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/add%20subject%20cubit/add_subject_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddNewStudent extends StatelessWidget {
  const AddNewStudent({Key? key, required this.subIndex}) : super(key: key);

  final int subIndex;

  deleteStudent(index, subject, context) async {
    List s = [];
    for (int i = 0; i < subject['students'].length; i++) {
      if (i != index) {
        s.add(subject['students'][i]);
      }
    }
    await FirebaseFirestore.instance
        .collection('students')
        .doc(subject['name'])
        .set({
      'name': subject['name'],
      'teacher': subject['teacher'],
      'students': s
    });
    BlocProvider.of<AddSubjectCubit>(context).getAllSubjects();
  }

  addStudent(subject, name, bill, context) async {
    List s = subject['students'];
    s.add({'name': name, 'bill': int.parse(bill)});
    await FirebaseFirestore.instance
        .collection('students')
        .doc(subject['name'])
        .set({
      'name': subject['name'],
      'teacher': subject['teacher'],
      'students': s
    });
    Navigator.pop(context);
    BlocProvider.of<AddSubjectCubit>(context).getAllSubjects();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController billController = TextEditingController();
    return BlocBuilder<AddSubjectCubit, AddSubjectState>(
      builder: (context, state) {
        if (state is AddSubjectInitial) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Добавить ученика'),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: CustomColors.gray),
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      controller: billController,
                                      cursorColor: CustomColors.background,
                                      style: ttwhite16W500,
                                      decoration: const InputDecoration(
                                          hintText: 'Оплата',
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
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(colors: [
                                          Colors.purple.shade900,
                                          Colors.blue,
                                          Colors.purple,
                                        ])),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (nameController.text != '' &&
                                            billController.text != '') {
                                          addStudent(
                                              state.subjects[subIndex],
                                              nameController.text,
                                              billController.text,
                                              context);
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
                                        'Добавить ученика',
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
                child: ModalProgressHUD(
                  inAsyncCall: state.isLoaded,
                  color: Colors.black,
                  progressIndicator: const CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.transparent,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.subjects.isNotEmpty
                              ? state.subjects[subIndex]['students'].length
                              : 0,
                          itemBuilder: (context, index) {
                            List students =
                                state.subjects[subIndex]['students'];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          students[index]['name'],
                                          style: ttblack16W400,
                                        ),
                                        Text(
                                          students[index]['bill'].toString(),
                                          style: ttblack16W400,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 3),
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.red),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          deleteStudent(
                                              index,
                                              state.subjects[subIndex],
                                              context);
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
                                          'Удалить',
                                          style: white12W400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
