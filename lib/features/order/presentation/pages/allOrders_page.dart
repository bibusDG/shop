import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/order/presentation/getx/order_controller.dart';

class AllOrdersPage extends GetView<OrderController> {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 430,
      child: Scaffold(
        appBar: const PreferredSize(preferredSize: Size.fromHeight(70.0), child: CustomAppBar(appBarTitle: 'Zamówienia')),
        body: StreamBuilder(
            stream: controller.streamOrders(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              if(snapshot.hasData){
                if(snapshot.data.length > 0){
                  return ListView.builder(
                      itemExtent: 250,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int amount){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 180,),
                            Row(
                              children: [
                                SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    shape: BoxShape.circle
                                  ),
                                ),
                                SizedBox(width: 10.0,),
                                Container(
                                  height: 3.0,
                                  width: 110,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 10.0,),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle
                                  ),
                                ),
                                SizedBox(width: 10.0,),
                                Container(
                                  height: 3.0,
                                  width: 110,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 10.0,),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Zamówione'),
                                Text('W przygotowaniu'),
                                Text('Gotowe'),
                              ],
                            ),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    );
                  });
                }return CircularProgressIndicator();

              }else{
                return const Center(child: Text('Brak zamówień'));
              }
            }),
      ),
    );
  }
}
