import 'dart:ui';

import 'package:fab_lab/bloc/calendar%20cubit/calendar_cubit.dart';
import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    BlocProvider.of<CalendarCubit>(context).getDays(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is CalendarInitial) {
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
                      const Text(
                        'Мои занятия',
                        style: ttwhite18W700,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 160, 10, 177),
                                    Color.fromARGB(255, 102, 27, 240),
                                    Color.fromARGB(255, 73, 121, 255),
                                  ])),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: RadialGradient(radius: 3, colors: [
                                    Colors.grey.shade900.withOpacity(0.5),
                                    Colors.grey.shade300.withOpacity(0.3),
                                    Colors.white.withOpacity(0.3),
                                  ]),
                                ),
                                child: TableCalendar(
                                  firstDay: DateTime(2022, 10, 1),
                                  lastDay: DateTime(2022, 10, 31),
                                  focusedDay: DateTime.now(),
                                  calendarStyle: CalendarStyle(
                                      disabledTextStyle:
                                          const TextStyle(color: Colors.grey),
                                      weekendTextStyle: TextStyle(
                                          color: CustomColors.background
                                              .withOpacity(0.5)),
                                      markerDecoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  daysOfWeekStyle: const DaysOfWeekStyle(
                                      weekdayStyle:
                                          TextStyle(color: Colors.blue),
                                      weekendStyle:
                                          TextStyle(color: Colors.pink)),
                                  headerVisible: false,
                                  eventLoader: (day) {
                                    for (int i = 0; i < state.days.length; i++) {
                                      if (day.weekday == state.days[i]) {
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
        return const SizedBox();
      },
    );
  }
}
