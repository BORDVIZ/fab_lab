import 'package:fab_lab/bloc/bottom%20bar%20cubit/bottom_bar_cubit.dart';
import 'package:fab_lab/bloc/loading%20cubit/loading_cubit.dart';
import 'package:fab_lab/bloc/user%20cubit/user_cubit.dart';
import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:fab_lab/pages/add_admin_page.dart';
import 'package:fab_lab/pages/admin_main_page.dart';
import 'package:fab_lab/pages/calendar_page.dart';
import 'package:fab_lab/pages/check_page.dart';
import 'package:fab_lab/pages/present_stat.dart';
import 'package:fab_lab/widgets/custom_admin_bottom_bar.dart';
import 'package:fab_lab/widgets/custom_bottom_bar.dart';
import 'package:fab_lab/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUserModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        if (state is BottomBarInitial) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              if (userState is UserInitial) {
                return BlocBuilder<LoadingCubit, LoadingState>(
                  builder: (context, loadingState) {
                    if (loadingState is LoadingInitial) {
                      return ModalProgressHUD(
                        inAsyncCall: loadingState.isLoaded,
                        color: Colors.black,
                        progressIndicator: const CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
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
                                  padding: const EdgeInsets.only(
                                      top: 60, bottom: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.4),
                                          child: userState.userModel['sex'] ==
                                                  'male'
                                              ? Image.asset(
                                                  'assets/images/male.png')
                                              : Image.asset(
                                                  'assets/images/female.png'),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          userState.userModel['name'] ?? '',
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
                                      SizedBox(
                                          child:
                                          userState.userModel['isAdmin']!=null?
                                          userState.userModel['isAdmin']? 
                                          state.page == 0? const AdminMainPage()
                                            :state.page ==1?const AddAdminPage()
                                              :state.page ==2?const PresentStatPage()
                                                :state.page ==3?const AddAdminPage()
                                                  :const SizedBox()                                   
                                          :state.page == 0
                                            ? const HomePage()
                                            : state.page == 1
                                                ? const CheckPage()
                                                : state.page == 2
                                                    ? const CalendarPage()
                                                    : const SizedBox()
                                                      :const SizedBox()),
                                      userState.userModel['isAdmin']==null
                                      ?const SizedBox()
                                      :!userState.userModel['isAdmin']?
                                      const Positioned(
                                        bottom: 0,
                                        child: CustomBottomBar(),
                                      ):const Positioned(
                                        bottom: 0,
                                        child: CustomAdminBottomBar(),)
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
              return const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
