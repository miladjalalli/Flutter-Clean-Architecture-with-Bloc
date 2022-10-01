import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/usecase.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/repositories/get_news_repository.dart';
import 'package:either_dart/either.dart';

class GetLastNewsFromDatabaseUseCase implements UseCase<GetNewsResponseDto, String> {
  final GetNewsRepository repository;

  GetLastNewsFromDatabaseUseCase({@required this.repository});

  @override
  Future<Either<Failure, GetNewsResponseDto>> call(String params) async {
    return await repository.fetchLastSavedNews();
  }
}
