import 'package:fab_lab/bloc/present%20stat%20cubit/present_stat_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PresentStatPage extends StatefulWidget {
  const PresentStatPage({Key? key}) : super(key: key);

  @override
  State<PresentStatPage> createState() => _PresentStatPageState();
}

class _PresentStatPageState extends State<PresentStatPage> {
  @override
  void initState() {
    BlocProvider.of<PresentStatCubit>(context).getPresentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresentStatCubit, PresentStatState>(
      builder: (context, state) {
        if (state is PresentStatInitial) {
          return ModalProgressHUD(
              inAsyncCall: state.isLoaded,
              color: Colors.black,
              progressIndicator: const CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.transparent,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.presentStat.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (_) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 600,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: CustomColors.gray,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      )),
                                  child: ListView.builder(
                                    itemCount: state
                                        .presentStat[index]['students'].length,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(child: Text(state.presentStat[index]['students'][ind], style: ttblack16W400,)),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Text(
                                state.presentStat[index]['lesson'],
                                style: ttblack16W400,
                              ),
                              Text(
                                state.presentStat[index]['name'],
                                style: ttblack16W400,
                              ),
                              Text(
                                state.presentStat[index]['date'],
                                style: ttblack16W400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
        }
        return const SizedBox();
      },
    );
  }
}
