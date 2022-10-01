import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/data/datasources/news_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/data/datasources/news_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/repositories/get_news_repository.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/usecases/get_news_usecase.dart';

import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';

class GetNewsRepositoryImpl implements GetNewsRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GetNewsRepositoryImpl({@required this.remoteDataSource, @required this.localDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, GetNewsResponseDto>> getNews(GetNewsParams params) async {
    if (await networkInfo.isConnected) {
      Either<Failure, GetNewsResponseDto> remoteData = await remoteDataSource.getNews(params);
      if (remoteData.isLeft)
        return Left(remoteData.left);
      else {
        localDataSource.cacheNews(remoteData.right);
        return Right(remoteData.right);
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetNewsResponseDto>> fetchLastSavedNews() async {
    try {
      final localData = await localDataSource.getLastNews();
      return Right(localData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
