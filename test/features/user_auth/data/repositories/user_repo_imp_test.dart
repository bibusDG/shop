import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/user_auth/data/datasources/user_firebase_data_source.dart';
import 'package:shop/features/user_auth/data/models/user_model.dart';
import 'package:shop/features/user_auth/data/repositories/user_repo_imp.dart';
import 'package:shop/features/user_auth/user_failure.dart';

class MockUserFirebaseDataSource extends Mock implements UserFirebaseDataSource{}

void main() {

  late UserFirebaseDataSource userFirebaseDataSource;
  late UserRepoImp userRepoImp;

  setUp((){
    userFirebaseDataSource = MockUserFirebaseDataSource();
    userRepoImp = UserRepoImp(userFirebaseDataSource: userFirebaseDataSource);
  });

  const createFailureMessage = UserCreateFailure(failureMessage: 'Not able to create new user');
  const loginFailureMessage = UserLoginFailure(failureMessage: 'Unable to login, please try again');
  
  group('Create new user', () {
    const String userID = 'userID';
    const String userName = 'userName';
    const String userSurname = 'userSurname';
    const String userEmail = 'userEmail';
    const String userPassword = 'userPassword';
    const String userMobilePhone = 'userMobilePhone';
    const String userCity = 'userCity';
    const String userPostalCode = 'userPostalCode';
    const String userAddress = 'userAddress';
    const bool isAdmin = false;
    const int userBonusPoints = 0;
    const double voucherValue = 0.0;
    
    test('should call [UserFirebaseDataSource.createUser] and finish successfuly', () async{
      when(()=>userFirebaseDataSource.createUser(
          voucherValue: any(named: 'voucherValue'),
          userID: any(named: 'userID'),
          userName: any(named: 'userName'),
          userSurname: any(named: 'userSurname'),
          userEmail: any(named: 'userEmail'),
          userPassword: any(named: 'userPassword'),
          userMobilePhone: any(named: 'userMobilePhone'),
          userCity: any(named: 'userCity'),
          userPostalCode: any(named: 'userPostalCode'),
          userAddress: any(named: 'userAddress'),
          userBonusPoints: any(named: 'userBonusPoints'),
          isAdmin: false,)).thenAnswer((_) async => Future.value());

      final result = await userRepoImp.createNewUser(
          voucherValue: voucherValue,
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

      expect(result, equals(const Right(null)));
      verify(()=>userFirebaseDataSource.createUser(
          voucherValue: voucherValue,
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
          isAdmin: isAdmin)).called(1);
      verifyNoMoreInteractions(userFirebaseDataSource);

    });
    ///***************************************
    
    test('Should return failureMessage, when connection unsuccessful', () async{

      when(() => userFirebaseDataSource.createUser(
        voucherValue: any(named: 'voucherValue'),
        userID: any(named: 'userID'),
        userName: any(named: 'userName'),
        userSurname: any(named: 'userSurname'),
        userEmail: any(named: 'userEmail'),
        userPassword: any(named: 'userPassword'),
        userMobilePhone: any(named: 'userMobilePhone'),
        userCity: any(named: 'userCity'),
        userPostalCode: any(named: 'userPostalCode'),
        userAddress: any(named: 'userAddress'),
        userBonusPoints: any(named: 'userBonusPoints'),
        isAdmin: false,)).thenThrow(createFailureMessage);

      final result = await userRepoImp.createNewUser(
          voucherValue: voucherValue,
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
      
      expect(result, equals(Left(UserCreateFailure(failureMessage: createFailureMessage.failureMessage))));
    });
    
  });

  group('LoginUser', () {

    test('should call [UserFirebaseDataSource.loginUser] and give back UserModel', () async {

      const testResponse = UserModel.empty();

      when(() => userFirebaseDataSource.loginUser(
          userPassword: any(named: 'userPassword'),
          userEmail: any(named: 'userEmail')),).thenAnswer((_) async => testResponse);


      final result = await userRepoImp.loginUser(
          userEmail: testResponse.userPassword,
          userPassword: testResponse.userID);

      expect(result, equals(const Right(testResponse)));
    });

    ///**********************************

    test('should return failure message, when getting user not possible', () async{
      when(() => userFirebaseDataSource.loginUser(
          userPassword: any(named: 'userPassword'),
          userEmail: any(named: 'userEmail'))).thenThrow(loginFailureMessage);

      final result = await userRepoImp.loginUser(
          userEmail: 'userEmail',
          userPassword: 'userPassword');

      expect(result, equals(Left(UserLoginFailure(failureMessage: loginFailureMessage.failureMessage))));

    });
  });

}
