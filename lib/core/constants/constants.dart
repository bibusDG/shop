import 'package:shop/features/user_auth/domain/entities/user.dart';

const COMPANY_NAME = 'mal0ry';

///PAYMENTS
const STRIPE_TEST_KEY = 'pk_test_51LokqwFYYlz5ocHQfLYxAMmsYAunf1cyz7zrAadysxlpbF0oFigAqrjqNZIQMAMEw3WlZVCI2NMx5DY1FepjzfdX00ViVsfmfz';
const CONTENT_TYPE = 'application/x-www-form-urlencoded';
const AUTH_KEY = 'Bearer sk_test_51LokqwFYYlz5ocHQp6hA6Qo5kY8jJhMZ0evZicPrX56WeRMWB6b8wA1EzAEr2N3PWyN74DZECRrSyvCQadHK9P5v00cno9B6kd';
const INTENT_CURRENCY = 'PLN';
const INTENT_AMOUNT = '10000';


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

