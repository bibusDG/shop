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
    isAdmin: false,
    voucherValue: 0,
    productsForFree: 0,
    mobileToken: '',
);

const double COURIER_COST = 20;

const String deleteCategoryInfo =
    'Przed usunięciem danej kategorii naciśnij "Anuluj", przejdź do produktów'
    'i usuń wszystkie elemnty znajdujące się w tej kategorii.'
    'Jeśli wiesz, że w przyszłości stworzysz na nowo kategorię'
    'o tej samej nazwie i chcesz pozostawić jej produktu na później'
    'naciśnij "Usuń".\nKategoria zostanie usunięta ale produkty znajdujące się w niej '
    'będą mogły być w przyszłości powiązane z tą kategorią na nowo.';

