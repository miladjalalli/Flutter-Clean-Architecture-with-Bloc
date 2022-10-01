
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:either_dart/either.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
