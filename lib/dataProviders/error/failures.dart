import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

// general failures
class UnexpectedFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ExpireFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UserExistsFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NotFoundFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UniqueFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UniqueTransferNumberFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ReceiveFailure extends Failure {
  @override
  List<Object> get props => [];
}

class PasswordFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UnauthenticatedFailure extends Failure {
  @override
  List<Object> get props => [];
}

class BlockedFailure extends Failure {
  @override
  List<Object> get props => [];
}

class PermissionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidCoponFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ExpiredCoponFailure extends Failure {
  @override
  List<Object> get props => [];
}

class AttachmentsRequiredFailure extends Failure {
  @override
  List<Object> get props => [];
}

class OTPRequiredFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UniqueIdentificationNumberFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UniqueUserIdentifierFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidInputDataFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidPINFailure extends Failure {
  @override
  List<Object> get props => [];
}

class InvalidEmailVerifyCodeFailure extends Failure {
  @override
  List<Object> get props => [];
}

class BalanceFailure extends Failure {
  @override
  List<Object> get props => [];
}

class UserAccountExistsFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ValidationFailure extends Failure {
  String errorMessage;

  ValidationFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'عذراً لم نتمكن من الاتصال بالخادم';
    case CacheFailure:
      return 'لاتوجد بيانات حتى الان حاول الإتصال بالإنترنت';
    case ConnectionFailure:
      return 'لايوجد اتصال بالانترنت!';
    case NotFoundFailure:
      return 'لاتوجد أي بيانات في الوقت الحالي!';
    case InvalidFailure:
      return 'هناك خطا في البيانات المدخلة';
    case ExpireFailure:
      return 'انتهت صلاحية الكود';
    case UserExistsFailure:
      return 'لايوجد حساب بهذه البيانات! تأكد من البيانات.';
    case UniqueFailure:
      return 'قد يكون هذا الحساب موجود مسبقاً! \nحاول تغيير البيانات المدخلة ';
    case UniqueTransferNumberFailure:
      return 'رقم الحوالة موجود من قبل تأكد من إدخال رقم الحوالة بشكل صحيح';
    case PasswordFailure:
      return 'كلمة المرور غير صحيحة';
    case ReceiveFailure:
      return 'حدث خطأ اثناء استقبال البيانات';
    case UnauthenticatedFailure:
      return 'عذرا ! أنت غير مخول لهذه العملية قم بتجسيل الدخول مرة أخرى والمحاولة';
    case PermissionFailure:
      return 'عذرا ! ليس لديك الصلاحية لإتمام هذه العملية';
    case BlockedFailure:
      return 'عذرا ! لقد تم حظر حسابك. يرجى التواصل مع المسؤول لإزالة الحظر';
    case InvalidCoponFailure:
      return 'عذرا ! رمز الكوبون غير صحيح';
    case ExpiredCoponFailure:
      return 'عذرا ! هذا الكوبون منتهي الصلاحية';
    case AttachmentsRequiredFailure:
      return 'عذرا ! يجب اضافة مرفقات';
    case OTPRequiredFailure:
      return 'عذرا ! يجب تأكيد حسابك';
    case UniqueIdentificationNumberFailure:
      return 'عذرا ! رقم الهوية مستخدم من مسبقاً';
    case UniqueUserIdentifierFailure:
      return 'عذرا ! المعرف الشخصي موجود مسبقاً';
    case InvalidInputDataFailure:
      return 'عذرا ! لقد ادخلت البيانات بشكل خاطىء';
    case InvalidPINFailure:
      return 'عذرا ! كود ال PIN غير صحيح ';
    case InvalidEmailVerifyCodeFailure:
      return 'عذرا ! رمز التحقق غير صحيح ';
    case BalanceFailure:
      return 'عذرا ! رصيدك غير كافي لإتمام العملية';
    case UserAccountExistsFailure:
      return 'عذرا ! ليس لديك حساب بعد';
    default:
      return 'عذراً حدث خطأ غير متوقع';
  }
}


