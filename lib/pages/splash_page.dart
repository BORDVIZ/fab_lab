import 'dart:async';

import 'package:fab_lab/pages/initial_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: -1.0, end: 1.0).animate(controller);
    controller.forward();
    Timer(const Duration(seconds: 4), () {
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const InitialPage(),
            transitionDuration: const Duration(milliseconds: 700),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          )
        );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(),
          child: Column(
            children: [
            //  Expanded(
            //       child: FadeTransition(
            //     opacity: animation,
            //     child: SvgPicture.asset(
            //       'assets/svg/Fablab.svg',
            //       width: width * 0.7,
            //       color: Colors.white,
            //     ),
            //   )), 
              Image.asset(
                'assets/images/logo.png',
                width: width * 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
