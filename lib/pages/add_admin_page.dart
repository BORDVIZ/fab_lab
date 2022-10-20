import 'dart:ui';

import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../bloc/present cubit/present_cubit.dart';

class AddAdminPage extends StatefulWidget {
  const AddAdminPage({Key? key}) : super(key: key);

  @override
  State<AddAdminPage> createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  @override
  void initState() {
    BlocProvider.of<PresentCubit>(context).getAllStudents(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<PresentCubit, PresentState>(
      builder: (context, state) {
        if (state is PresentInitial) {
          return BlocBuilder<LoadingCubit, LoadingState>(
            builder: (context, loading) {
              if (loading is LoadingInitial) {
                return ModalProgressHUD(
                        inAsyncCall: loading.isLoadedScreen,
                        color: Colors.black,
                        progressIndicator: const CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Добавить кретерии',
                          style: ttwhite18W700,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.students.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      gradient: const RadialGradient(
                                          radius: 5,
                                          colors: [
                                            Color.fromARGB(255, 63, 50, 157),
                                            Color.fromARGB(255, 160, 10, 177),
                                            Colors.blue,
                                          ]),
                                      border: Border.all(
                                          color: Colors.white, width: 0.2),
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
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            gradient: RadialGradient(
                                                radius: 3,
                                                colors: [
                                                  Colors.grey.shade900
                                                      .withOpacity(0.5),
                                                  Colors.grey.shade300
                                                      .withOpacity(0.3),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: CustomColors
                                                          .background
                                                          .withOpacity(0.25)),
                                                  child: Text(
                                                    state.students[index]['name']??'',
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
                                ),
                              ));
                        },
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}