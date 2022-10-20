import 'dart:ui';

import 'package:fab_lab/bloc/news%20cubit/news_cubit.dart';
import 'package:fab_lab/constants/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsInitial) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.news.length,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10),
                  child: Stack(
                    children: [
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(-4 / 360),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color.fromARGB(255, 160, 10, 177)
                                        .withOpacity(0.6),
                                    const Color.fromARGB(255, 73, 121, 255)
                                        .withOpacity(0.55),
                                    const Color.fromARGB(255, 102, 27, 240)
                                        .withOpacity(0.6),
                                  ])),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.news[index]['name']??'',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'TTNorms'),
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    radius: 20,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    state.news[index]['text']??'',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'TTNorms'),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Colors.grey.shade900.withOpacity(0.5),
                                      Colors.grey.shade300.withOpacity(0.3),
                                      Colors.white.withOpacity(0.3),
                                    ])),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.news[index]['name']??'',
                                      style: white16W600,
                                    ),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.4),
                                      child: Image.asset(state.news[index]['sex']=='male'?'assets/images/male.png':'assets/images/female.png'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      state.news[index]['text']??'',
                                      style: ttwhite16W500,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
