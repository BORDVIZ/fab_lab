import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_lab/bloc/add%20user%20cubit/add_user_cubit.dart';
import 'package:fab_lab/bloc/days%20cubit/days_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddDaysPage extends StatefulWidget {
  const AddDaysPage({Key? key}) : super(key: key);

  @override
  State<AddDaysPage> createState() => _AddDaysPageState();
}

class _AddDaysPageState extends State<AddDaysPage> {
  @override
  void initState() {
    BlocProvider.of<DaysCubit>(context).clearAll();
    BlocProvider.of<AddUserCubit>(context).getAllUsers();
    super.initState();
  }

  sendDays(days, name) async {
    const List namesOfDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List d = [];
    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        d.add(namesOfDays[i]);
      }
    }
    if(d.isNotEmpty){
      await FirebaseFirestore.instance.collection('days').doc(name).set({'name': name, 'days': d});
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Дни добавлены')),
      );
      
    }else{
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Поле не может быть пустым')),
      );
    }
    BlocProvider.of<DaysCubit>(context).clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (_) {
                                const List allDays = [
                                  'Понедельник',
                                  'Вторник',
                                  'Среда',
                                  'Четверг',
                                  'Пятница',
                                  'Суббота',
                                  'Воскресенье'
                                ];
                                return Container(
                                  height: 600,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: CustomColors.gray,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      )),
                                  child: BlocBuilder<DaysCubit, DaysState>(
                                    builder: (context, daysState) {
                                      if (daysState is DaysInitial) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: allDays.length,
                                                itemBuilder: (context, ind) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5,
                                                                horizontal: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              allDays[ind],
                                                              style:
                                                                  ttwhite18W700,
                                                            ),
                                                            FloatingActionButton(
                                                                onPressed: () {
                                                                  BlocProvider.of<
                                                                              DaysCubit>(
                                                                          context)
                                                                      .addDay(
                                                                          daysState
                                                                              .days,
                                                                          ind);
                                                                },
                                                                heroTag: null,
                                                                mini: true,
                                                                backgroundColor: daysState
                                                                            .days[
                                                                        ind]
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                child: const Icon(
                                                                    Icons
                                                                        .check_outlined))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50),
                                                width: double.infinity,
                                                height: 50,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    sendDays(
                                                        daysState.days,
                                                        state.users[index]
                                                            ['name']);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          CustomColors
                                                              .background,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                      shadowColor: Colors.white
                                                          .withOpacity(0.15)),
                                                  child: const Text(
                                                    'Добавить дни',
                                                    style: ttwhite18W700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                );
                              });
                        },
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
                      ),
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
