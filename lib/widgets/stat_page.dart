import 'dart:ui';

import 'package:fab_lab/constants/custom_colors.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';

class StatPage extends StatelessWidget {
  const StatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Суммарно за Октябрь: 12.600 ₽',
            style: ttwhite16W500,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    radius: 3,
                    colors: [
                      Color.fromARGB(255, 72, 50, 238),
                      Color.fromARGB(255, 63, 50, 157),
                      Colors.white,
                    ]
                  ),
                  border: Border.all(color: Colors.white, width: 0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: 3,
                          colors: [
                            Colors.grey.shade900.withOpacity(0.5),
                            Colors.grey.shade300.withOpacity(0.3),
                            Colors.white.withOpacity(0.3),
                          ]
                        ),
                        border: Border.all(color: Colors.white, width: 0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: CustomColors.background,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset('assets/images/fab_lab.png', color: Colors.white,),
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
                                  color: CustomColors.background.withOpacity(0.25)
                                ),
                                child: Column(
                                  children: [
                                    const Text('Робототехника', style: ttwhite16W500,),
                                    Text('За Октябрь: 4.200 ₽', style: ttgray16W600,)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            );
          },
        ),
      ],
    );
  }
}