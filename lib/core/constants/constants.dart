import 'package:shop/features/user_auth/domain/entities/user.dart';

const COMPANY_NAME = 'sudol_coo';

const EMPTY_USER = User(
    userID: '',
    userName: '',
    userSurname: '',
    userEmail: '',
    userPassword: '',
    userMobilePhone: '',
    userCity: '',
    userAddress: '',
    userPostalCode: '',
    userBonusPoints: 0,
    isAdmin: false);