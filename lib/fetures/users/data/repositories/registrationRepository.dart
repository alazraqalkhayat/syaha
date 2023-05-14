
import 'package:dartz/dartz.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../../../dataProviders/local_data_provider.dart';
import '../../../../dataProviders/network/Network_info.dart';
import '../../../../dataProviders/network/data_source_url.dart';
import '../../../../dataProviders/remote_data_provider.dart';
import '../../../../dataProviders/repository.dart';
import '../models/EditProfileModel.dart';
import '../models/SignUpModel.dart';
import '../models/loginModel.dart';
import '../models/userModel.dart';

class RegistrationRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  RegistrationRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });

  late UserModel userModel;

  Future<Either<Failure, dynamic>> signup(
      {required SignUpModel signUpModel}) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
            url: DataSourceURL.signup,
            retrievedDataType: String,
            returnType: String,
            body: signUpModel.toJson());

        return remoteData;
      },
    );
  }

  Future<Either<Failure, dynamic>> login(
      {required LoginModel loginModel}) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
          url: DataSourceURL.login,
          retrievedDataType: UserModel.init(),
          body: loginModel.toJson(),
        );

        userModel = remoteData;
        localDataProvider.cacheData(key: 'USER', data: userModel.toJson());

        return remoteData;
      },
    );
  }

  Future<Either<Failure, dynamic>> sendVerifyCode(
      {required String email}) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
            url: DataSourceURL.login,
            retrievedDataType: String,
            returnType: String,
            body: {
              'email': email,
            });

        return remoteData;
      },
    );
  }

  Future<Either<Failure, dynamic>> checkVerifyCode(
      {required String email, code}) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
            url: DataSourceURL.login,
            retrievedDataType: String,
            returnType: String,
            body: {
              'email': email,
              'code': code,
            });

        return remoteData;
      },
    );
  }

  Future<Either<Failure, dynamic>> editPassword(
      {required String email, password}) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
            url: DataSourceURL.login,
            retrievedDataType: String,
            returnType: String,
            body: {
              'email': email,
              'password': password,
            });

        return remoteData;
      },
    );
  }

  Future<Either<Failure, dynamic>> editUserProfile(
      {required EditProfileModel editProfileModel}) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
          url: DataSourceURL.login,
          retrievedDataType: UserModel.init(),
          body: editProfileModel.toJson(),
        );
        userModel = remoteData;
        localDataProvider.cacheData(key: 'USER', data: userModel.toJson());

        return remoteData;
      },
    );
  }

  Future<Either<Failure, dynamic>> logout({required String token}) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
            url: DataSourceURL.logout,
            retrievedDataType: String,
            returnType: String,
            body: {
              'api_token': token,
            });

        return remoteData;
      },
    );
  }
}
