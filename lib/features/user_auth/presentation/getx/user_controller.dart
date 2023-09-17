import 'package:get/get.dart';
import 'package:shop/features/user_auth/domain/usecases/create_user_usecase.dart';

class UserController extends GetxController{
  final CreateUserUseCase createUserUseCase;
  UserController({required this.createUserUseCase});

  Future<void> createUser() async{
    final user = await createUserUseCase(
        const CreateUserParams(
            userID: "",
            userName: "userName",
            userSurname: "userSurname",
            userEmail: "userEmail",
            userPassword: "userPassword",
            userMobilePhone: "userMobilePhone",
            userCountry: "userCountry",
            userAddress: "userAddress",
            userPostalCode: "userPostalCode",
            isAdmin: false));
    user.fold((failure) {
      return Get.snackbar('failure', "failure");
    }, (user) {
      return Get.snackbar('success', 'well done');
    });
  }
}