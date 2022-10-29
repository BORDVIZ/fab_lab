
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/present%20cubit/present_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MarkSudentsPage extends StatelessWidget {
  const MarkSudentsPage({Key? key, required this.ind}) : super(key: key);
  final int ind;

  void sendPresent(context, String name, String teacher, List students) async {
    List<String> present = [];
    for (int i = 0; i < students.length; i++) {
      if (students[i]['present']) {
        present.add(students[i]['name']);
      }
    }
    await FirebaseFirestore.instance.collection('present').doc('${name}_${teacher}_${DateFormat('yMMMMd').format(DateTime.now())}').set({
      'date': DateFormat('yMMMMd').format(DateTime.now()),
      'lesson': name,
      'name': teacher,
      'students': present
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Список отправлен')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return BlocBuilder<PresentCubit, PresentState>(
      builder: (context, state) {
        if (state is PresentInitial) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Отметить присутствующих',
                style: ttwhite18W700,
              ),
              backgroundColor: CustomColors.background,
            ),
            body: SizedBox(
              width: w,
              height: h,
              child: Stack(
                children: [
                  SizedBox(
                    width: w,
                    height: h,
                    child: Image.asset(
                      'assets/images/back.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: w,
                    height: h,
                    color: CustomColors.background.withOpacity(0.9),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.students[ind]['students'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.students[ind]['students'][index]
                                            ['name'],
                                        style: ttwhite18W700,
                                      ),
                                      FloatingActionButton(
                                          onPressed: () {
                                            BlocProvider.of<PresentCubit>(
                                                    context)
                                                .addPresent(
                                                    state.students,
                                                    state.present,
                                                    ind,
                                                    index,
                                                    state.present[ind]
                                                            ['students'][index]
                                                        ['present']);
                                          },
                                          heroTag: null,
                                          mini: true,
                                          backgroundColor: state.present[ind]
                                                  ['students'][index]['present']
                                              ? Colors.green
                                              : Colors.black.withOpacity(0.5),
                                          child:
                                              const Icon(Icons.check_outlined))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          width: w,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              sendPresent(
                                  context,
                                  state.students[ind]['name'],
                                  state.students[ind]['teacher'],
                                  state.present[ind]['students']);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.background,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                shadowColor: Colors.white.withOpacity(0.15)),
                            child: const Text(
                              'Отправить список',
                              style: ttwhite18W700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
