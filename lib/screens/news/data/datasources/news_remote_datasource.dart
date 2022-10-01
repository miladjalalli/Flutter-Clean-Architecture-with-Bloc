import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/network/rest_client_service.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/data/models/get_news_response_model.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';

import '../../../../core/error/failures.dart';
import 'package:either_dart/either.dart';

import '../../domain/usecases/get_news_usecase.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, GetNewsResponseDto>> getNews(GetNewsParams params);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final RestClientService restClientService;

  LoginRemoteDataSourceImpl({@required this.restClientService});

  @override
  Future<Either<Failure, GetNewsResponseDto>> getNews(GetNewsParams params) async {
    final response = await restClientService.getNews(params.toJson());
    if (response.statusCode != 200) {
      return Left(ServerFailure(response.error));
    }
    return Right(GetNewsResponseDto.fromJson(jsonDecode(response.body)));
  }
}
