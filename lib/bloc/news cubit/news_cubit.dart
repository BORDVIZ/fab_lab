import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial(news: const []));

  getNews() async {
    try {
      List<Map<String, dynamic>> l = [];
      Map<String, dynamic> map;
      await FirebaseFirestore.instance
          .collection('news')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          map = {
            'name': doc['name'],
            'text': doc['text'],
            'sex': doc['sex']
          };
          l.add(map);
        }
        emit(NewsInitial(news: l.reversed.toList()));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
