import 'package:shop/core/failures/failure.dart';

class UserCreateFailure extends Failure{
  const UserCreateFailure({required super.failureMessage});
}

class UserLoginFailure extends Failure{
  const UserLoginFailure({required super.failureMessage});
}

class UserDeleteFailure extends Failure{
  const UserDeleteFailure({required super.failureMessage});
}

class UserModifyFailure extends Failure{
  const UserModifyFailure({required super.failureMessage});
}