import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/dataProviders/local_data_provider.dart';
import 'package:myapp/dataProviders/network/Network_info.dart';
import 'package:myapp/dataProviders/remote_data_provider.dart';
import 'package:myapp/fetures/addPlace/data/repository/homeRepository.dart';
import 'package:myapp/fetures/addPlace/presentation/manager/place_bloc.dart';
import 'package:myapp/fetures/contactUs/data/repository/contactUsRepository.dart';
import 'package:myapp/fetures/contactUs/presentation/manager/contact_us_bloc.dart';
import 'package:myapp/fetures/favorite/data/repository/favoriteRepository.dart';
import 'package:myapp/fetures/favorite/presentation/manager/favorite_bloc.dart';
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
  _initPlaceFeature();
  _initContactUsFeature();
  _initFavoriteFeature();

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
void _initPlaceFeature() {
//bloc
  sl.registerFactory(() => PlaceBloc(repository: sl()));
  //repositories
  sl.registerLazySingleton<PlaceRepository>(
        () => PlaceRepository(
      remoteDataProvider: sl(),
      localDataProvider: sl(),
      networkInfo: sl(),
    ),
  );

}
void _initContactUsFeature() {
//bloc
  sl.registerFactory(() => ContactUsBloc(repository: sl()));
  //repositories
  sl.registerLazySingleton<ContactUsRepository>(
        () => ContactUsRepository(
      remoteDataProvider: sl(),
      localDataProvider: sl(),
      networkInfo: sl(),
    ),
  );

}
void _initFavoriteFeature() {
//bloc
  sl.registerFactory(() => FavoriteBloc(repository: sl()));
  //repositories
  sl.registerLazySingleton<FavoriteRepository>(
        () => FavoriteRepository(
      remoteDataProvider: sl(),
      localDataProvider: sl(),
      networkInfo: sl(),
    ),
  );

}













