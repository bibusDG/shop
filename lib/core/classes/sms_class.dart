

import 'package:flutter_sms/flutter_sms.dart';

class SendSms{
  final String? paymentMethod;
  final String? orderValue;
  final String orderNumber;
  final String mobilePhoneNumber;
  final String? operationStatus;
  const SendSms({
    this.paymentMethod,
    this.orderValue,
    required this.orderNumber,
    required this.mobilePhoneNumber,
    this.operationStatus,
});

  sendSmsToUser() async{

    String IN_PROGRESS_MESSAGE =
        'Zamówienie nr.${orderNumber} zmieniło status.\n '
        'Aktualnie przygotowujemy twoje zamówienie';

    String ORDER_READY_MESSAGE =
        'Zamówienie nr.${orderNumber} zmieniło status.\n '
        'Zamówienie gotowe do wysyłki lub odbioru';

      if(operationStatus == 'W przygotowaniu'){
        await sendSMS(message: IN_PROGRESS_MESSAGE, recipients: [mobilePhoneNumber]);
      }else if(operationStatus == 'Gotowe'){
        await sendSMS(message: ORDER_READY_MESSAGE, recipients: [mobilePhoneNumber]);
      }
  }

  sendInfoAboutOrder(){

    String GENERAL_INFO = ''
        'Aby sprawdzić status zamówienia oraz metodę płatności\n'
        'przejdź do zakładki "Zamówienia"\n'
        'Wszystkie informację dotyczące danych do przelewu znajdziesz\n'
        'na stronie glównej w zakładce "Realizacja zmówień".';

    String CASH_MESSAGE =
        'Dziękujemy za złożenie zamówienia nr.${orderNumber}.\n'
        'Przygotuj ${orderValue} PLN i zapłać pzy odbiorze. \n'
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
      return CASH_MESSAGE;
    }else if(paymentMethod == 'bank_account'){
      return TRANSFER_MESSAGE;
    }else if(paymentMethod =='blik'){
      return BLIK_MESSAGE;
    }else{
      return VOUCHER_MESSAGE;
    }

  }

}

