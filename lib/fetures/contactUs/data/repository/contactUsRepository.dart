
import 'package:dartz/dartz.dart';
import 'package:myapp/fetures/home/data/model/groupsModel.dart';

import '../../../../dataProviders/error/failures.dart';
import '../../../../dataProviders/local_data_provider.dart';
import '../../../../dataProviders/network/Network_info.dart';
import '../../../../dataProviders/network/data_source_url.dart';
import '../../../../dataProviders/remote_data_provider.dart';
import '../../../../dataProviders/repository.dart';


class ContactUsRepository extends Repository {
  final RemoteDataProvider remoteDataProvider; //get the data from the internet
  final LocalDataProvider localDataProvider; //get the data from the local cache
  final NetworkInfo networkInfo; //check if the device is connected to internet

  ContactUsRepository({
    required this.remoteDataProvider,
    required this.localDataProvider,
    required this.networkInfo,
  });


  Future<Either<Failure, dynamic>> contactRequest({
    required name,
    required email,
    required message,

  }) async {
    return await sendRequest(
      checkConnection: networkInfo.isConnected,
      remoteFunction: () async {
        final remoteData = await remoteDataProvider.sendData(
            url: DataSourceURL.contactUs,
            retrievedDataType: String,
            returnType: String,
            body: {
              'name':name,
              'email':email,
              'message':message,
            });

        return remoteData;
      },
    );
  }


}
