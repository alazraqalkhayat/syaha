import 'dart:convert';
import 'dart:developer';
import 'package:myapp/injection_container.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import './error/exceptions.dart';
import './network/data_source_url.dart';
import 'local_data_provider.dart';

class RemoteDataProvider {
  final http.Client client;

  RemoteDataProvider({required this.client});

  Future<dynamic> sendData({
    required String url,
    required Map<String, dynamic> body,
    required retrievedDataType,
    dynamic returnType,
  }) async {
    log('send data lunched ');

    log('body is ' + body.toString());
    log("I am here " + url);


    final response = await client.post(
      Uri.parse(DataSourceURL.baseUrl + url),
      body: body,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${body['api_token'] ?? ""}',
        'deviceUnique': LocalDataProvider(
            sharedPreferences: sl<SharedPreferences>())
            .getCachedData(key: 'DEVICE_UNIQUE',
            returnType: String,
            retrievedDataType: String),

      },
    );

    log(DataSourceURL.baseUrl + url);
    log("response.body " + response.body.toString());
    log(response.statusCode.toString());
    // log("returnType "+returnType.toString());

    if (response.statusCode == 200) {
      log('the status code is 200');
      if (returnType == List) {
        final List<dynamic> data = json.decode(response.body);
        log('the data data type is List');
        log("the data from return type is ${retrievedDataType.fromJsonList(
            data)}");

        return retrievedDataType.fromJsonList(data);
      } else if (returnType == int) {
        final dynamic data = response.body;
        return data;
      } else if (returnType == String) {
        print('the data is string ');
        final dynamic data = json.decode(response.body);
        return data;
      } else {
        final dynamic data = json.decode(response.body);
        log('remote data provider is $data');

        if (data is List) {
          if (data.isEmpty) {
            log('data exception');
            throw EmptyException();
          } else {
            print('data is not empty');
          }
        }

        print('data is $data');
        return retrievedDataType.fromJson(data);
      }
    } else if (response.statusCode == 201) {
      return 1;
    } else if (response.statusCode == 401) {
      throw UnauthenticatedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 409) {
      throw PermissionException();
    } else if (response.statusCode == 406) {
      throw InvalidException();
    } else if (response.statusCode == 410) {
      throw ExpireException();
    } else if (response.statusCode == 430) {
      throw UniqueException();
    } else if (response.statusCode == 431) {
      throw UniqueTransferNumberException();
    } else if (response.statusCode == 434) {
      throw UserExistsException();
    } else if (response.statusCode == 439) {
      throw BlockedException();
    } else if (response.statusCode == 433) {
      throw ReceiveException();
    } else if (response.statusCode == 411) {
      throw InvalidCoponException();
    } else if (response.statusCode == 412) {
      throw ExpiredCoponException();
    } else if (response.statusCode == 413) {
      throw AttachmentsRequiredException();
    } else if (response.statusCode == 414) {
      throw OTPRequiredException();
    } else if (response.statusCode == 415) {
      throw UniqueUserIdentifierException();
    } else if (response.statusCode == 416) {
      throw UniqueIdentificationNumberException();
    } else if (response.statusCode == 417) {
      throw InvalidInputDataException();
    } else if (response.statusCode == 418) {
      throw InvalidPINException();
    } else if (response.statusCode == 419) {
      throw InvalidEmailVerifyCodeException();
    } else if (response.statusCode == 420) {
      throw BalanceException();
    } else if (response.statusCode == 421) {
      throw UserAccountExistsException();
    } else if (response.statusCode == 422) {
      throw ValidationException(response.body);
    }
      // } else if (response.statusCode == 500) {
      throw ServerException();
    }
  }

