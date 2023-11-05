import 'package:get/get.dart';
import 'package:shop/core/constants/constants.dart';

import '../../domain/entities/user.dart';

class UserDataController extends GetxController{
  User userData = EMPTY_USER;
  late RxBool userLoginStatus = false.obs;
  RxDouble voucherValue = 0.0.obs;
  RxInt bonusPointsValue = 0.obs;
  RxInt freeProducts = 0.obs;
}