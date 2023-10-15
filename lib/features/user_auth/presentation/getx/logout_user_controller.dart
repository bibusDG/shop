import 'package:get/get.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/features/user_auth/domain/usecases/logout_user_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

class LogOutUserController extends GetxController{
  LogOutUserUseCase useCase;
  LogOutUserController({required this.useCase});

  Future<void> logOutUser() async{

    UserDataController userData = Get.find();

    final result = await useCase();
    result.fold((error){
      return Get.snackbar('Uwaga', 'Coś poszło nie tak');
    }, (login){
      userData.userLoginStatus.value = false;
      userData.userData = EMPTY_USER;
      return Get.snackbar('Udało się', 'Zostałes poprawnie wylogowany');
    });
  }

}