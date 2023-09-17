import 'package:dartz/dartz.dart';
import 'package:shop/features/user_auth/domain/entities/user.dart';

import '../../../../core/failures/failure.dart';

abstract class UserRepo {
  const UserRepo();

  Future<Either<Failure, void>> createNewUser({
    required String userID,
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String userMobilePhone,
    required String userCountry,
    required String userPostalCode,
    required String userAddress,
    required bool isAdmin,
});

  Future<Either<Failure, void>> deleteUser({
    required String userEmail,
    required String  userPassword,
});

  Future<Either<Failure, User>> loginUser({
    required String userEmail,
    required String userPassword,
});

  Future<Either<Failure, void>> modifyUserData();

}