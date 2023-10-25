import 'package:get/get.dart';
import 'package:shop/features/user_auth/domain/usecases/modify_user_usecase.dart';
import 'package:shop/features/user_auth/presentation/getx/create_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/logout_user_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

class ModifyUserController extends GetxController{
  ModifyUserUseCase modifyUserUseCase;
  ModifyUserController({required this.modifyUserUseCase});

  Future<void> setTextValues() async{

    CreateUserController createUserController = Get.find();
    UserDataController userDataController = Get.find();

    createUserController.userPasswordTextField.text = userDataController.userData.userPassword;
    createUserController.userMobilePhoneTextField.text = userDataController.userData.userMobilePhone;
    createUserController.userAddressTextField.text = userDataController.userData.userAddress;
    createUserController.userPostalCodeTextField.text = userDataController.userData.userPostalCode;
    createUserController.userCityTextField.text = userDataController.userData.userCity;
    createUserController.userEmailTextField.text = userDataController.userData.userEmail;
    createUserController.userSurnameTextField.text = userDataController.userData.userSurname;
    createUserController.userNameTextField.text = userDataController.userData.userName;
  }

  Future<void> modifyUser() async{

    CreateUserController createUserController = Get.find();
    UserDataController userDataController = Get.find();
    LogOutUserController logOutUserController = Get.find();

    final result = await modifyUserUseCase(
        ModifyUserParams(
        userAddress: createUserController.userAddressTextField.text,
        userPostalCode: createUserController.userPostalCodeTextField.text,
        userMobilePhone: createUserController.userMobilePhoneTextField.text,
        userEmail: createUserController.userEmailTextField.text,
        userSurname: createUserController.userSurnameTextField.text,
        userName: createUserController.userNameTextField.text,
        userPassword: createUserController.userPasswordTextField.text,
        userCity: createUserController.userCityTextField.text,
        userID: userDataController.userData.userID));
    result.fold((error){
      return Get.snackbar('Uwaga', 'Nie można zmienić danych');
    }, (update) async{
      await logOutUserController.logOutUser();
      Get.snackbar('Zapisano zmiany', 'Zaloguj się ponownie w celu...');
      await Get.toNamed('/start_page');
    });

  }

}