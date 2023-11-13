

import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop/features/notifications/presentation/getx/user_notification_controller.dart';

class NotificationText{
  final String? paymentMethod;
  final String? orderValue;
  final String orderNumber;
  final String mobileToken;
  final String? operationStatus;
  const NotificationText({
    this.paymentMethod,
    this.orderValue,
    required this.orderNumber,
    required this.mobileToken,
    this.operationStatus,
});

  sendNotificationToUser() async{

    UserNotificationController userNotificationController = Get.find();

    String IN_PROGRESS_MESSAGE =
        'Zamówienie nr.${orderNumber} zmieniło status.\n'
        'Aktualnie przygotowujemy twoje zamówienie';

    String ORDER_READY_MESSAGE =
        'Zamówienie nr.${orderNumber} zmieniło status.\n'
        'Zamówienie gotowe do wysyłki lub odbioru';

      if(operationStatus == 'W przygotowaniu'){
            userNotificationController.sendNotificationToUser(
            mobileToken: mobileToken,
            notificationText: IN_PROGRESS_MESSAGE,
            notificationTopic: 'Zamówienie nr. $orderNumber'
        );
      }else if(operationStatus == 'Gotowe'){
            userNotificationController.sendNotificationToUser(
            mobileToken: mobileToken,
            notificationText: ORDER_READY_MESSAGE,
            notificationTopic: 'Zamówienie nr. $orderNumber'
        );
      }
  }

  sendNotificationInfoAboutOrder(){

    UserNotificationController userNotificationController = Get.find();

    String GENERAL_INFO = ''
        'Aby sprawdzić status zamówienia oraz metodę płatności przejdź do zakładki "Zamówienia"\n'
        'Wszystkie informację dotyczące danych do przelewu znajdziesz na stronie glównej w zakładce "Realizacja zmówień".';

    String CASH_MESSAGE =
        'Dziękujemy za złożenie zamówienia nr.${orderNumber}.\n'
        'Przygotuj ${orderValue} PLN i zapłać pzy odbiorze.\n'
        'O stausach zamówienia będziesz informowany w sms.\n\n$GENERAL_INFO';

    String BLIK_MESSAGE =
        'Dziękujemy za złożenie zamówienia nr.${orderNumber}.\n'
        'Przelej kwotę ${orderValue} PLN za pomocą BLIK na numer telefonu +48601201875. \n'
        'O statusach zamówienia będziesz informowany w sms\n\n$GENERAL_INFO';

    String TRANSFER_MESSAGE =
        'Dziękujemy za złożenie zamówienia nr.${orderNumber}.\n'
        'Przelej kwotę ${orderValue} PLN na numer konta 00039853973987364. \n'
        'O statusach zamówienia będziesz informowany w sms\n\n$GENERAL_INFO';

    String VOUCHER_MESSAGE =
        'Dziękujemy za złożenie zamówienia nr.${orderNumber}.\n'
        'O statusach zamówienia będziesz informowany w sms\n\n$GENERAL_INFO';

    if(paymentMethod == 'cash'){
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: CASH_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }else if(paymentMethod == 'bank_account'){
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: TRANSFER_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }else if(paymentMethod =='blik'){
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: BLIK_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }else{
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: VOUCHER_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }

  }

}

