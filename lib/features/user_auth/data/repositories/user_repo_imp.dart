import 'package:dartz/dartz.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/features/user_auth/data/datasources/user_firebase_data_source.dart';
import 'package:shop/features/user_auth/domain/entities/user.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';
import 'package:shop/features/user_auth/user_failure.dart';

class UserRepoImp implements  UserRepo{
  final UserFirebaseDataSource userFirebaseDataSource;
  const UserRepoImp({required this.userFirebaseDataSource});
  @override
  Future<Either<Failure, void>> createNewUser({
    required String userID,
    required String userName,
    required String userSurname,
    required String userEmail,
    required String userPassword,
    required String userMobilePhone,
    required String userCity,
    required String userPostalCode,
    required String userAddress,
    required bool isAdmin,
    required int userBonusPoints,
  }) async{
    try{
      final result = await userFirebaseDataSource.createUser(
          userID: userID,
          userName: userName,
          userSurname: userSurname,
          userEmail: userEmail,
          userPassword: userPassword,
          userMobilePhone: userMobilePhone,
          userCity: userCity,
          userPostalCode: userPostalCode,
          userAddress: userAddress,
          userBonusPoints: userBonusPoints,
          isAdmin: isAdmin);
      return Right(result);
    }catch(error){
      return const Left(UserCreateFailure(failureMessage: 'Not able to create new user'));
    }
    // TODO: implement createNewUser
    // throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteUser({
    required String userID,
    required String userEmail,
    required String userPassword}) async{
    try{
      final result = await userFirebaseDataSource.deleteUser(
          userID: userID,
          userPassword: userPassword,
          userEmail: userEmail);
      return Right(result);
    }catch(error){
      return const Left(UserDeleteFailure(failureMessage: 'Not possible to delete user'));
    }
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> loginUser({
    required String userEmail,
    required String userPassword}) async{
    try{
      final result = await userFirebaseDataSource.loginUser(
          userPassword: userPassword,
          userEmail: userEmail);
      return Right(result);
    }catch(error){
      return const Left(UserLoginFailure(failureMessage: 'Unable to login, please try again'));
    }
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> modifyUserData() {
    // TODO: implement modifyUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logOutUser() {
    // TODO: implement logOutUser
    throw UnimplementedError();
  }
  
}