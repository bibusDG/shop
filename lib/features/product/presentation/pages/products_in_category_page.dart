import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import '../../../product/presentation/getx/product_controller.dart';
import '../../domain/entities/product.dart';


class ProductsInCategoryPage extends GetView<ProductController> {
  const ProductsInCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ResponsiveScaledBox(
        width: 430,
        child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: CustomAppBar(appBarTitle: 'Produkty')),
          body: StreamBuilder(
              stream: controller.streamProducts(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasData){
                  if(snapshot.data.length > 0){
                    return ListView.builder(
                        itemExtent: 180,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          Product product = snapshot.data[index];
                          return GestureDetector(
                            onTap: () async{
                              await controller.getProduct(productID: product.productID);
                              Get.toNamed('/product_details_page');
                            },
                            child:Card(
                              color: Colors.red,
                              child: Center(child:Text(product.productName)),
                            ),
                          );
                        });
                  }else{
                    return const Center(child: Text('No data'));
                  }
                }else{
                  return const Center(child: CircularProgressIndicator());
                }

              }),
        ));
  }
}