import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';


class MockUserRepo extends Mock implements UserRepo {}

void main() {
  late CreateUserUseCase useCase;
  late UserRepo repo;

  setUp((){
    repo = MockUserRepo();
    useCase = CreateUserUseCase(userRepo: repo);
  });

  const params = CreateUserParams.empty();
  test('should call [CreateUserUseCase.createNewUser]', () async{
    //Arrange
    when(()=> repo.createNewUser(
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
        isAdmin: false,
    )).thenAnswer((_) async => const Right(null));

    //Act
    final result = await useCase(params);
    
    //Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(()=>repo.createNewUser(
        voucherValue: params.voucherValue,
        userID: params.userID,
        userName: params.userName,
        userSurname: params.userSurname,
        userEmail: params.userEmail,
        userPassword: params.userPassword,
        userMobilePhone: params.userMobilePhone,
        userCity: params.userCity,
        userPostalCode: params.userPostalCode,
        userAddress: params.userAddress,
        userBonusPoints: params.userBonusPoints,
        isAdmin: params.isAdmin)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
