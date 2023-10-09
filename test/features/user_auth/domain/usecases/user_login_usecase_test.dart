import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop/features/user_auth/domain/entities/user.dart';
import 'package:shop/features/user_auth/domain/repositories/user_repo.dart';
import 'package:shop/features/user_auth/domain/usecases/user_login_usecase.dart';

class MockUserRepo extends Mock implements UserRepo {}

void main() {
  late UserRepo repo;
  late LoginUserUseCase useCase;

  setUp((){
    repo = MockUserRepo();
    useCase = LoginUserUseCase(userRepo: repo);
  });
  const testResponse = User.empty();
  const params = LoginParams.empty();
  test('should call [LoginUserUseCase.loginUser] and give back [User]', () async{
    //Arrange
    when(() => repo.loginUser(
        userEmail: any(named: 'userEmail'),
        userPassword: any(named: 'userPassword')),
    ).thenAnswer((_) async => const  Right(testResponse));

    //Act
    final result = await useCase(params);
    //Assert
    expect(result, equals(const Right<dynamic, User>(testResponse)));
    verify(()=>repo.loginUser(
        userEmail: params.userEmail,
        userPassword: params.userPassword)
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
