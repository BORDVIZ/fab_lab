import 'dart:async';
import 'dart:ui';

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
  late AnimationController controller2;
  late Animation<double> animation2;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween<double>(begin: -1.0, end: 1.0).animate(controller);
    controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation2 = Tween<double>(begin: -1.0, end: 1.0).animate(controller2);
    controller.forward();
    Timer(const Duration(seconds: 2), () => controller2.forward());
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
          child: Stack(
            children: [
              SizedBox(
                height: height,
                width: width,
              ),
              FadeTransition(
                opacity: animation2,
                child: SizedBox(
                  width: width,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: width * 0.8,
                          height: width * 0.8,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                Colors.pinkAccent.withOpacity(0.3),
                                Colors.purple.withOpacity(0.3),
                                Colors.blue.withOpacity(0.3),
                                Colors.blue.withOpacity(0.3),
                              ])),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: animation2,
                child: SizedBox(
                  width: width,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: width * 0.7,
                          height: width * 0.7,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                Colors.pinkAccent.withOpacity(0.4),
                                Colors.purple.withOpacity(0.4),
                                Colors.blue.withOpacity(0.4),
                                Colors.blue.withOpacity(0.4),
                              ])),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: animation2,
                child: SizedBox(
                  width: width,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: width * 0.6,
                          height: width * 0.6,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                Colors.pinkAccent.withOpacity(0.5),
                                Colors.purple.withOpacity(0.5),
                                Colors.blue.withOpacity(0.5),
                                Colors.blue.withOpacity(0.5),
                              ])),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width,
                child: Center(
                  child: FadeTransition(
                    opacity: animation,
                    child: Image.asset(
                      'assets/images/fab_lab.png',
                      width: width * 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: width,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: width * 0.15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
