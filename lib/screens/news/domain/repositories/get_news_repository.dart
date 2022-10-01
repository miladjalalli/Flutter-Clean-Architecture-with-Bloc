
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:either_dart/either.dart';

import '../usecases/get_news_usecase.dart';

abstract class GetNewsRepository {
  Future<Either<Failure, GetNewsResponseDto>> getNews(GetNewsParams params);
  Future<Either<Failure, GetNewsResponseDto>> fetchLastSavedNews();
}
