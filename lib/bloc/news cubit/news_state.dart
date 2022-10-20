part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {
  NewsInitial({required this.news});
  List<Map<String, dynamic>> news;
}
