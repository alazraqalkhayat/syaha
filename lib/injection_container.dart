import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/dataProviders/local_data_provider.dart';
import 'package:myapp/dataProviders/network/Network_info.dart';
import 'package:myapp/dataProviders/remote_data_provider.dart';
import 'package:myapp/fetures/home/data/repository/homeRepository.dart';
import 'package:myapp/fetures/home/presentation/manager/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fetures/users/data/repositories/registrationRepository.dart';
import 'fetures/users/presentation/manager/registration/registrationBloc.dart';



final sl = GetIt.instance; //sl = service locator

Future<void> init() async {
  print('start injection');

//  ! Features
  _initRegisterFeature();
  _initHomeFeature();

  ///service provider

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //data providers

  // data sources
  sl.registerLazySingleton<RemoteDataProvider>(() => RemoteDataProvider(client: sl()));
  sl.registerLazySingleton<LocalDataProvider>(() => LocalDataProvider(sharedPreferences: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

}

///registration
void _initRegisterFeature() {
//bloc
  sl.registerFactory(() => RegistrationBloc(repository: sl()));
  //repositories
  sl.registerLazySingleton<RegistrationRepository>(
        () => RegistrationRepository(
      remoteDataProvider: sl(),
      localDataProvider: sl(),
      networkInfo: sl(),
    ),
  );

}
void _initHomeFeature() {
//bloc
  sl.registerFactory(() => HomeBloc(repository: sl()));
  //repositories
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepository(
      remoteDataProvider: sl(),
      localDataProvider: sl(),
      networkInfo: sl(),
    ),
  );

}













