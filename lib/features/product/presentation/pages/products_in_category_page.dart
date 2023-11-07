import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/classes/string_to_image.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';
import '../../../product/presentation/getx/product_controller.dart';
import '../../domain/entities/product.dart';


class ProductsInCategoryPage extends GetView<ProductController> {
  const ProductsInCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserDataController userDataController = Get.find();
    

    return Scaffold(
      backgroundColor: Colors.white,
          bottomSheet: userDataController.userData.isAdmin == true? IconButton(onPressed: () {
            controller.resetCreateProductTextFields();
            Get.toNamed('/create_product_page');
          },
              icon: const Icon(Icons.add, size: 60,))
              : const SizedBox(),
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: CustomAppBar(appBarTitle: 'Produkty')),
          body: StreamBuilder(
              stream: controller.streamProducts(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasData){
                  if(snapshot.data.length > 0){
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:0.9,
                          crossAxisCount: 2),
                        // itemExtent: 180,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          Product product = snapshot.data[index];
                          return GestureDetector(
                            onTap: () async{
                              await controller.getProduct(productID: product.productID);
                              Get.toNamed('/product_details_page');
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      product.productGallery.isNotEmpty?
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fitHeight,
                                                image: const StringToImage().getSingleImage(image: product.productGallery[0]).image),
                                              borderRadius: BorderRadius.circular(5.0),
                                              color: Colors.white
                                          ),
                                          width: double.infinity/2,
                                        ),
                                      ) : const AspectRatio(
                                        aspectRatio: 1,
                                        child: SizedBox(
                                          width: double.infinity/2,
                                          child: Center(child:Text('Brak zdjęcia')),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Center(child:Text(product.productName.toUpperCase(),
                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w200, decoration: TextDecoration.underline),)),
                                    ],
                                  ),
                                ),
                                userDataController.userData.isAdmin == true?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(onPressed: () async{
                                      await Get.defaultDialog(
                                        title: 'Uwaga',
                                        content: Column(
                                          children: [
                                            const Text('Czy na pewno chcesz usunąć ten produkt ?'),
                                            const SizedBox(height: 30.0,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                              CupertinoButton(child: const Text('Usuń'), onPressed: () async{
                                                Get.back();
                                                await controller.deleteProduct(productID: product.productID);

                                              }),
                                                CupertinoButton(child: const Text('Anuluj'), onPressed: (){
                                                  Get.back();
                                                })
                                            ],),
                                          ],
                                        ),
                                      );


                                    }, icon: const Icon(Icons.delete, size: 55, color: Colors.blue,)),
                                    IconButton(onPressed: () async{
                                      await controller.setEditProductData(product: product);
                                      Get.toNamed('/create_product_page');
                                    }, icon: const Icon(Icons.edit, size: 55, color: Colors.blue,)),
                                  ],
                                ) : const SizedBox(),
                              ],
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
        );
  }
}