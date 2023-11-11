import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shop/core/failures/failure.dart';
import 'package:shop/core/usecases/usecases.dart';
import 'package:shop/features/notifications/domain/repositories/user_notification_repo.dart';

class UpdateUserTokenUseCase implements UseCasesWithParams<void, TokenParams>{
  final UserNotificationRepo repo;
  const UpdateUserTokenUseCase({required this.repo});
  @override
  Future<Either<Failure, void>> call(TokenParams params) async{
    return await repo.updateUserMobileToken(
        userID: params.userID,
        mobileToken: params.mobileToken);
    // TODO: implement call
    throw UnimplementedError();
  }

}

class TokenParams extends Equatable{
  final String userID;
  final String mobileToken;
  const TokenParams({
    required this.mobileToken,
    required this.userID,
});

  const TokenParams.empty() : this(
    userID: 'userID',
    mobileToken: 'mobileToken',
  );

  @override
  List<Object> get props => [userID, mobileToken];
}