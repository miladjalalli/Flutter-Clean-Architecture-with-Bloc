import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/usecase.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/repositories/get_news_repository.dart';
import 'package:either_dart/either.dart';

class GetNewsUseCase implements UseCase<GetNewsResponseDto, GetNewsParams> {
  final GetNewsRepository repository;

  GetNewsUseCase({@required this.repository});

  @override
  Future<Either<Failure, GetNewsResponseDto>> call(GetNewsParams params) async {
    return await repository.getNews(params);
  }
}

class GetNewsParams {
  String category;

  GetNewsParams({this.category});

  GetNewsParams.fromJson(Map<String, dynamic> json) {
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    return data;
  }
}