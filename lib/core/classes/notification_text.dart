

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop/core/constants/constants.dart';
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

  sendNotificationToAdmin() async{

    ///get admin token
    final admin = await FirebaseFirestore.instance.collection('company').
        doc(COMPANY_NAME).
        collection('users').where('isAdmin', isEqualTo: true).get();
    var adminMap = admin.docs.first.data();
    String adminToken = adminMap['mobileToken'];

    ///message text to admin
    String MESSAGE_TO_ADMIN = 'Zostało złożone nowe zamówienie nr $orderNumber w dniu\n'
        '${DateTime.now().toString().substring(0,10)}';

    UserNotificationController userNotificationController = Get.find();

    ///send notification to admin via controller
    userNotificationController.sendNotificationToAdmin(
        mobileToken: adminToken,
        notificationText: MESSAGE_TO_ADMIN,
        notificationTopic: 'Nowe zamówienie nr. $orderNumber');

  }

  sendNotificationToUser() async{

    UserNotificationController userNotificationController = Get.find();

    ///messages about order status
    String IN_PROGRESS_MESSAGE =
        'Zamówienie nr.${orderNumber} zmieniło status.\n'
        'Aktualnie przygotowujemy twoje zamówienie';

    String ORDER_READY_MESSAGE =
        'Zamówienie nr.${orderNumber} zmieniło status.\n'
        'Zamówienie gotowe do wysyłki lub odbioru';

      if(operationStatus == 'W przygotowaniu'){

        ///send notification to user if order in progress
            userNotificationController.sendNotificationToUser(
            mobileToken: mobileToken,
            notificationText: IN_PROGRESS_MESSAGE,
            notificationTopic: 'Zamówienie nr. $orderNumber'
        );
      }else if(operationStatus == 'Gotowe'){

        ///send notification to user if order is ready
            userNotificationController.sendNotificationToUser(
            mobileToken: mobileToken,
            notificationText: ORDER_READY_MESSAGE,
            notificationTopic: 'Zamówienie nr. $orderNumber'
        );
      }
  }

  sendNotificationInfoAboutOrder() async{

    UserNotificationController userNotificationController = Get.find();

    ///text depending on user payment type
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

      ///send notification if payment is cash
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: CASH_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }else if(paymentMethod == 'bank_account'){

      ///send notification if payment is transfer
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: TRANSFER_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }else if(paymentMethod =='blik'){

      ///send notification if payment is blik
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: BLIK_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }else{

      ///send notification if payment is voucher
      userNotificationController.sendNotificationToUser(
          mobileToken: mobileToken,
          notificationText: VOUCHER_MESSAGE,
          notificationTopic: 'Zamówienie nr. $orderNumber');
    }

  }

}

