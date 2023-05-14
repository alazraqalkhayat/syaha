class ServerException implements Exception {}

class CacheException implements Exception {}

class EmptyException implements Exception {}

class InvalidException implements Exception {}

class NotFoundException implements Exception {}

class ExpireException implements Exception {}

class UniqueException implements Exception {}

class UniqueTransferNumberException implements Exception {}

class UserExistsException implements Exception {}

class ReceiveException implements Exception {}

class PasswordException implements Exception {}

class UnexpectedException implements Exception {}

class UnauthenticatedException implements Exception {}

class BlockedException implements Exception {}

class PermissionException implements Exception {}

class InvalidCoponException implements Exception {}

class ExpiredCoponException implements Exception {}

class AttachmentsRequiredException implements Exception {}

class OTPRequiredException implements Exception {}

class UniqueIdentificationNumberException implements Exception {}

class UniqueUserIdentifierException implements Exception {}

class InvalidInputDataException implements Exception {}

class InvalidPINException implements Exception {}

class InvalidEmailVerifyCodeException implements Exception {}

class BalanceException implements Exception {}

class UserAccountExistsException implements Exception {}

class ValidationException implements Exception {
  dynamic error;

  ValidationException(this.error);
}


