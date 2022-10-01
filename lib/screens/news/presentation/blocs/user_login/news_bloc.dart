import 'package:bloc/bloc.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/usecases/get_news_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/get_last_news_from_database_usecase.dart';
import 'bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNews;
  final GetLastNewsFromDatabaseUseCase getLastNewsFromDatabase;

  NewsBloc({@required this.getNews, @required this.getLastNewsFromDatabase}) : super(LoadingNewsState()) {
    on<NewsEvent>((NewsEvent event, Emitter<NewsState> emit) async {
      if (event is GetNewsEvent) {
        emit(LoadingNewsState());
        Either<Failure, GetNewsResponseDto> result = await getNews(GetNewsParams(category: "technology"));
        result.fold((failure) async {
          if (failure is NoConnectionFailure) {
            emit(LoadingNewsErrorState(message: NO_CONNECTION_ERROR));
          } else if (failure is ServerFailure) {
            emit(LoadingNewsErrorState(message: failure.message));
          } else {
            emit(LoadingNewsErrorState(message: GET_NEWS_ERROR));
          }
        }, (success) async {
          emit(LoadingNewsSuccessState(newsResponseDto: success));
        });
      }else if (event is GetLastNewsFromDatabaseEvent){
        emit(LoadingNewsState());
        Either<Failure, GetNewsResponseDto> result = await getLastNewsFromDatabase(null);
        result.fold((failure) async {
          if (failure is CacheFailure) {
            emit(LoadingNewsErrorState(message: "Failed to Load From Database"));
          } else {
            emit(LoadingNewsErrorState(message: GET_NEWS_ERROR));
          }
        }, (success) async {
          emit(LoadingNewsSuccessState(newsResponseDto: success));
        });
      }
    });
  }

  @override
  NewsState get initialState => LoadingNewsState();
}
