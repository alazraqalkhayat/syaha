import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'error/exceptions.dart';
import 'error/failures.dart';

typedef Future<dynamic> GetDataFunction();
typedef dynamic GetCacheDataFunction();

class Repository {
  Future<Either<Failure, dynamic>> sendRequest({
    GetDataFunction? remoteFunction,
    GetCacheDataFunction? getCacheDataFunction,
    required Future<bool> checkConnection,
  }) async {
    log('send request running');

    if (await checkConnection) {
      log('check connection ');
      try {
        log('try from repositories');

        final remoteData = await remoteFunction!();
        log('the data from repositories is $remoteData');
        return Right(remoteData);
      } on InvalidException {
        return Left(InvalidFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      } on EmptyException {
        return Left(NotFoundFailure());
      } on UniqueException {
        return Left(UniqueFailure());
      } on UniqueTransferNumberException {
        return Left(UniqueTransferNumberFailure());
      } on ExpireException {
        return Left(ExpireFailure());
      } on UserExistsException {
        return Left(UserExistsFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on ReceiveException {
        return Left(ReceiveFailure());
      } on PermissionException {
        return Left(PermissionFailure());
      } on BlockedException {
        return Left(BlockedFailure());
      } on InvalidCoponException {
        return Left(InvalidCoponFailure());
      } on ExpiredCoponException {
        return Left(ExpiredCoponFailure());
      } on AttachmentsRequiredException {
        return Left(AttachmentsRequiredFailure());
      } on OTPRequiredException {
        return Left(OTPRequiredFailure());
      } on UniqueUserIdentifierException {
        return Left(UniqueUserIdentifierFailure());
      } on UniqueIdentificationNumberException {
        return Left(UniqueIdentificationNumberFailure());
      } on UnauthenticatedException {
        return Left(UnauthenticatedFailure());
      }on InvalidInputDataException {
        return Left(InvalidInputDataFailure());
      }on InvalidPINException {
        return Left(InvalidPINFailure());
      }on InvalidEmailVerifyCodeException {
        return Left(InvalidEmailVerifyCodeFailure());
      }on UserAccountExistsException {
        return Left(UserAccountExistsFailure());
      }on BalanceException {
        return Left(BalanceFailure());
      }on ValidationException catch(e){

        var de=jsonDecode(e.error);
        log('the error error is ${e}');
        log('the error error is ${de['data'][0]}');

        return Left(ValidationFailure(errorMessage:de['data'][0] ));
      } catch (Exception) {
        log('exception is  ${Exception}');
        return Left(ReceiveFailure());

        ///here is the error
      }
    } else {
      if (getCacheDataFunction == null) {
        return Left(ConnectionFailure());
      }

      try {
        final localData = getCacheDataFunction();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      } on EmptyException {
        return Left(NotFoundFailure());
      } catch (Exception) {
        print(Exception);
        return Left(ConnectionFailure());
      }
    }
  }
}
