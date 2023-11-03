import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/classes/photo_to_string.dart';
import 'package:shop/core/classes/string_to_image.dart';
import 'package:shop/core/constants/constants.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/features/product_categories/presentation/getx/product_category_controller.dart';
import 'package:shop/features/user_auth/presentation/getx/user_data_controller.dart';

import '../../../product/presentation/getx/product_controller.dart';
import '../../domain/entities/product_category.dart';

class ProductCategoryPage extends GetView<ProductCategoryController> {
  const ProductCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ProductController productController = Get.find();
    UserDataController userDataController = Get.find();

    return Scaffold(
        bottomSheet: userDataController.userData.isAdmin == true? IconButton(onPressed: (){
          Get.toNamed('/create_new_category_page');
        },
            icon: const Icon(Icons.add, size: 60,))
        : const SizedBox(),
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: CustomAppBar(appBarTitle: 'Kategorie')),
      body: StreamBuilder(
          stream: controller.streamProductCategory(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.0),
                    // itemExtent: 180,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      ProductCategory productCategory = snapshot.data[index];
                      return GestureDetector(
                        onLongPress: (){
                          productController.addProduct();
                        },
                        onTap: () async{
                          productController.productCategory = productCategory.productCategoryName;
                          Get.toNamed('/products_in_category_page');
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 20),
                              child:
                              Card(
                                color: Colors.black,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0)),
                                      height: 300,
                                      width: 300,
                                      child: productCategory.productCategoryPicture.isNotEmpty?
                                      Image(
                                        fit: BoxFit.fill,
                                        image: const StringToImage().getSingleImage(image: productCategory.productCategoryPicture).image,) :
                                      const Center(child:Text('Brak zdjęcia')),
                                    ),
                                    const SizedBox(height: 20.0,),
                                    Center(child: Text(productCategory.productCategoryName, style: const TextStyle(color: Colors.white),)),
                                  ],
                                ),
                              ),
                            ),
                            userDataController.userData.isAdmin == true?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 30.0,),
                                IconButton(
                                  onPressed: () async{
                                    Get.defaultDialog(
                                      title: 'Uwaga',
                                      content: Column(
                                        children: [
                                          const Text(deleteCategoryInfo),
                                          const SizedBox(height: 20.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CupertinoButton(
                                                  onPressed: () async{
                                                await controller.deleteCategory(productCategoryID: productCategory.productCategoryID);
                                              },
                                                  child: const Text('Usuń'),),
                                              CupertinoButton(
                                                  onPressed: (){Get.back();},
                                                  child: const Text('Anuluj'),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    );

                                }, icon: const Icon(Icons.delete, size: 65, color: Colors.blue,)),
                                IconButton(onPressed: () async{
                                  String categoryImage = await PhotoToString().takeAPhotoFromGallery();
                                  controller.modifyCategory(category: productCategory, image: categoryImage);

                                }, icon: const Icon(Icons.image, size: 65, color: Colors.blue,)),

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
