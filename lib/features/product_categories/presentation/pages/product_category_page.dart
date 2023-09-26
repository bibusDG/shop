import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/product_categories/presentation/getx/product_category_controller.dart';

class ProductCategoryPage extends GetView<ProductCategoryController> {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: 430,
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: CustomAppBar(appBarTitle: 'Kategorie')),
      body: StreamBuilder(
          stream: controller.streamProductCategory(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return ListView.builder(
                    itemExtent: 180,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return const Card(
                        color: Colors.red,
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

class Getview {
}
