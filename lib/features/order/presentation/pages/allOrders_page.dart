import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/order/presentation/getx/order_controller.dart';
import 'package:shop/features/order/presentation/pages/order_detail_page.dart';

import '../../data/models/user_order_model.dart';

class AllOrdersPage extends GetView<OrderController> {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(preferredSize: Size.fromHeight(70.0), child: CustomAppBar(appBarTitle: 'Zamówienia')),
        body: StreamBuilder(
            stream: controller.streamOrders(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              if(snapshot.hasData){
                if(snapshot.data.length > 0){
                  return ListView.separated(

                      // itemExtent: 180,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){

                        UserOrderModel order = snapshot.data[index];

                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: GestureDetector(
                        onTap: () async{
                          Get.toNamed('/order_detail_page', arguments: order);
                        },
                        child: Card(
                          elevation: 0,
                          // color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 20.0,),
                              Text('Zamówienie nr: ${order.orderNumber}'),
                              Text(order.orderTime.substring(0,10)),
                              const SizedBox(height: 40.0,),
                              // const SizedBox(height: 180,),
                              OrderStatusWidget(order: order),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Zamówione'),
                                  Text('W przygotowaniu'),
                                  Text('Gotowe'),
                                ],
                              ),
                              const SizedBox(height: 40.0,),
                            ],
                          ),
                        ),
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) { return
                    const Divider(endIndent: 20.0, indent: 20.0, color: Colors.black, thickness: 0.5,); },);
                }return const CircularProgressIndicator();

              }else{
                return const Center(child: Text('Brak zamówień'));
              }
            }),
      );

  }
}

class OrderStatusWidget extends StatelessWidget {
  final UserOrderModel order;
  const OrderStatusWidget({
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 10.0,),
        Container(
          height: 3.0,
          width: 110,
          color: order.orderStatus == 'W przygotowaniu' || order.orderStatus == 'Gotowe' ? Colors.black : Colors.grey,
        ),
        const SizedBox(width: 10.0,),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: order.orderStatus == 'W przygotowaniu' || order.orderStatus == 'Gotowe' ? Colors.black : Colors.grey,
              shape: BoxShape.circle
          ),
        ),
        const SizedBox(width: 10.0,),
        Container(
          height: 3.0,
          width: 110,
          color: order.orderStatus == 'Gotowe'? Colors.black : Colors.grey,
        ),
        const SizedBox(width: 10.0,),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              color: order.orderStatus == 'Gotowe'? Colors.black : Colors.grey,
              shape: BoxShape.circle
          ),
        ),
      ],
    );
  }
}
