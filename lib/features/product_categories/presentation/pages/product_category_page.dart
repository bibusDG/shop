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
        backgroundColor: Colors.white,
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
                            Card(
                              elevation: 0,
                              shadowColor: Colors.white,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  // const SizedBox(height: 20.0,),
                                  productCategory.productCategoryPicture.isNotEmpty?
                                  ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.transparent, Colors.black],
                                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.srcATop,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: const StringToImage().getSingleImage(image: productCategory.productCategoryPicture).image,),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      height: Get.width + 45,
                                      width: Get.width + 45
                                    ),
                                  ) : SizedBox(
                                      width: Get.width,
                                      height: Get.width,
                                      child: const Center(child:Text('Brak zdjęcia'))),
                                  // const SizedBox(height: 30.0,),
                                  // Center(child: Text(productCategory.productCategoryName.toUpperCase(),
                                  //   style: const TextStyle(decoration: TextDecoration.underline, color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w200),)),
                                ],
                              ),
                            ),
                            userDataController.userData.isAdmin == true?
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                ),
                                SizedBox(height: Get.width-80,),
                                Center(child: Text(productCategory.productCategoryName.toUpperCase(), style: const TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.white, color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w200),)),
                              ],
                            ) : Column(
                              children: [
                                SizedBox(height: Get.width),
                                Center(child: Text(productCategory.productCategoryName.toUpperCase(), style: const TextStyle(decoration: TextDecoration.underline, decorationColor: Colors.white, color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w200),)),
                              ],
                            ),
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
