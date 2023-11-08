import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/classes/photo_to_string.dart';
import 'package:shop/core/classes/string_to_image.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/core/custom_widgets/custom_text_form_field.dart';
import 'package:shop/features/product_categories/presentation/getx/product_category_controller.dart';

class CreateNewCategoryPage extends GetView<ProductCategoryController> {
  const CreateNewCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
            appBar: const PreferredSize(preferredSize: Size.fromHeight(70), child: CustomAppBar(appBarTitle: 'Nowa kategoria',)),
            body: Center(
              child: Obx(() {
                return Column(
                  children: [
                    const SizedBox(height: 20.0,),
                    CustomTextForm(
                        textEditingController: controller.productCategoryName,
                        obscureText: false,
                        hintText: '',
                        labelText: 'Nazwa kategorii',
                        mustContainText: '',
                        notAllowedText: '  ',
                        textLength: 0,
                        keyboardType: TextInputType.text),
                    const SizedBox(height: 20.0,),
                    CupertinoButton(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        child: const Text('Dodaj zdjęcie kategorii'), onPressed: () async {
                      final image = await PhotoToString().takeAPhotoFromGallery();
                      controller.categoryImage.value = image;
                    }),
                    controller.categoryImage.value.isNotEmpty ?
                    Column(
                      children: [
                        const SizedBox(height: 20.0,),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Card(
                            child: Image(
                              fit: BoxFit.fill,
                              image: const StringToImage()
                                  .getSingleImage(image: controller.categoryImage.value).image),
                          ),
                        ),
                      ],
                    ) : const SizedBox(),
                    const SizedBox(height: 20.0,),
                    CupertinoButton(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        child: const Text('Utwórz kategorię'), onPressed: () async {
                      await controller.createNewCategory();
                    }),
                  ],
                );
              }),
            ),
          ),
    );
  }
}
