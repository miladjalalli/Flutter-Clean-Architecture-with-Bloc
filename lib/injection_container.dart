import 'package:chopper/chopper.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/usecases/get_last_news_from_database_usecase.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/core/network/rest_client_service.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/data/repositories/get_news_repository_impl.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/usecases/get_news_usecase.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/presentation/blocs/user_login/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/news/data/datasources/news_local_datasource.dart';
import 'screens/news/data/datasources/news_remote_datasource.dart';
import 'screens/news/domain/repositories/get_news_repository.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs
  sl.registerFactory(
    () => NewsBloc(
      getNews: sl(),
      getLastNewsFromDatabase: sl(),
    )..add(GetNewsEvent()),
  );

  //Use cases
  sl.registerLazySingleton(() => GetNewsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetLastNewsFromDatabaseUseCase(repository: sl()));

  //Repositories
  sl.registerLazySingleton<GetNewsRepository>(
    () => GetNewsRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  //Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: sl()),
  );

  //External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
  final client = ChopperClient(
      baseUrl: API_BASE_URL,
      interceptors: [
    CurlInterceptor(),
    HttpLoggingInterceptor(),
  ]);
  sl.registerLazySingleton(() => RestClientService.create(client));
}
