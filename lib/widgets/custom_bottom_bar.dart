import 'dart:ui';

import 'package:fab_lab/bloc/bottom%20bar%20cubit/bottom_bar_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        if (state is BottomBarInitial) {
          return Container(
            width: w,
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(colors: [
                        Colors.grey.withOpacity(0.5),
                        CustomColors.light.withOpacity(0.5),
                      ])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap:() => BlocProvider.of<BottomBarCubit>(context).changePage(0), 
                        child: Image.asset(
                          'assets/icons/home.png',
                          width: 30,
                          color: state.page==0?Colors.white:CustomColors.background.withOpacity(0.85),
                        ),
                      ),
                      InkWell(
                        onTap:() => BlocProvider.of<BottomBarCubit>(context).changePage(1), 
                        child: Image.asset(
                          'assets/icons/chart.png',
                          width: 30,
                          color: state.page==1?Colors.white:CustomColors.background.withOpacity(0.85),
                        ),
                      ),
                      InkWell(
                        onTap:() => BlocProvider.of<BottomBarCubit>(context).changePage(2), 
                        child: Image.asset(
                          'assets/icons/check.png',
                          width: 30,
                          color: state.page==2?Colors.white:CustomColors.background.withOpacity(0.85),
                        ),
                      ),
                      InkWell(
                        onTap:() => BlocProvider.of<BottomBarCubit>(context).changePage(3), 
                        child: Image.asset(
                          'assets/icons/calendar.png',
                          width: 30,
                          color: state.page==3?Colors.white:CustomColors.background.withOpacity(0.85),
                        ),
                      ),
                    ],
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
