import 'package:equatable/equatable.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsState extends Equatable {
  NewsState([List props = const <dynamic>[]]) : super(props);
}

class LoadingNewsErrorState extends NewsState {
  final String message;
  LoadingNewsErrorState({@required this.message}) : super([message]);
}

class LoadingNewsState extends NewsState {}

class LoadingNewsSuccessState extends NewsState {
  final GetNewsResponseDto newsResponseDto;
  LoadingNewsSuccessState({@required this.newsResponseDto}) : super([newsResponseDto]);
}

