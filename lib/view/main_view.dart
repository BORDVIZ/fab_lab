import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/bottom%20bar%20cubit/bottom_bar_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:fab_lab/widgets/custom_bottom_bar.dart';
import 'package:fab_lab/widgets/home_page.dart';
import 'package:fab_lab/widgets/stat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  getDoc() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        //to do
      }
    });
  }

  @override
  void initState() {
    getDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        if (state is BottomBarInitial) {
          return SizedBox(
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
                Column(
                  children: [
                    Container(
                      width: w,
                      color: CustomColors.background,
                      padding: const EdgeInsets.only(top: 60, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white.withOpacity(0.4),
                              child: Image.asset('assets/images/male.png'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Борис Двизов',
                              style: white22W500,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                              child: state.page == 0
                                  ? const HomePage()
                                  : state.page == 1
                                      ? const StatPage()
                                      : state.page == 2
                                          ? const CheckPage()
                                          : state.page == 3
                                              ? const CalendarPage()
                                              : const SizedBox()),
                          const Positioned(
                            bottom: 0,
                            child: CustomBottomBar(),
                          )
                        ],
                      ),
                    ),
                  ],
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

class CheckPage extends StatelessWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Отметить присутсвующих',
            style: ttwhite18W700,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: InkWell(
                  onTap: () => print(index),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        gradient: const RadialGradient(radius: 1.5, colors: [
                          Colors.blue,
                          Color.fromARGB(255, 63, 50, 157),
                        ]),
                        border: Border.all(color: Colors.white, width: 0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: CustomColors.background,
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
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      CustomColors.background.withOpacity(0.3)),
                              child: const Text(
                                'Робототехника',
                                style: ttwhite16W500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          },
        ),
      ],
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> events = [
      DateTime(2022, 10, 22),
      DateTime(2022, 10, 25),
      DateTime(2022, 10, 4),
      DateTime(2022, 10, 11),
      DateTime(2022, 10, 18),
    ];
    return Column(
      children: [
        const Text(
          'Мои занятия',
          style: ttwhite18W700,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.light),
            child: TableCalendar(
              firstDay: DateTime(2022, 10, 1),
              lastDay: DateTime(2022, 10, 31),
              focusedDay: DateTime.now(),
              headerVisible: false,
              eventLoader: (day) {
                List days = [DateTime.monday, DateTime.wednesday];
                for (int i = 0; i < days.length;i++){
                  if (day.weekday == days[i]) {
                  return [day];
                }
                }
                return [];
              },
              availableCalendarFormats: const {
                CalendarFormat.month: '',
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
            ),
          ),
        ),
      ],
    );
  }
}
