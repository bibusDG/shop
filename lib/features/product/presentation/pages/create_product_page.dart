import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/classes/photo_to_string.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/core/custom_widgets/custom_text_form_field.dart';
import 'package:shop/features/product/presentation/getx/product_controller.dart';

class CreateProductPage extends GetView<ProductController> {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List productGallery = [];

    return ResponsiveScaledBox(
      width: 430,
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(70.0), child: CustomAppBar(appBarTitle: 'Nowy produkt/${controller.productCategory}')),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10.0,),
              CustomTextForm(
                  textEditingController: controller.productName,
                  obscureText: false,
                  hintText: '',
                  labelText: 'Nazwa produktu',
                  mustContainText: '',
                  notAllowedText: '  ',
                  textLength: 0,
                  keyboardType: TextInputType.text),
              SizedBox(
                width: 150,
                child: CustomTextForm(
                    textEditingController: controller.productPrice,
                    obscureText: false,
                    hintText: '',
                    labelText: 'Cena produktu',
                    mustContainText: '',
                    notAllowedText: ' ',
                    textLength: 0,
                    keyboardType: TextInputType.number),
              ),
              SizedBox(
                width: 150,
                child: CustomTextForm(
                    textEditingController: controller.productAvailability,
                    obscureText: false,
                    hintText: '',
                    labelText: 'Dostępna ilość',
                    mustContainText: '',
                    notAllowedText: ' ',
                    textLength: 0,
                    keyboardType: TextInputType.number),
              ),
              SizedBox(
                width: 300,
                height: 200,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: controller.productDescription,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),),
                    labelText: 'Opis produktu'
                  ),
                ),),
              const SizedBox(height: 20.0,),
              CupertinoButton(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
                  child: Text('Dodaj zdjęcia produktu'), onPressed: () async{
                  await PhotoToString().takeMultiplePhotoFromGallery();
              }),
              const SizedBox(height: 20.0),
              CupertinoButton(
                color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Text('Utwórz nowy produkt'), onPressed: () async{
                  await controller.addProduct();
                  await resetCreateProductTextFields();
              }),

            ],
          ),
        ),
      ),
    );
  }

  resetCreateProductTextFields(){

    ProductController productController = Get.find();

    productController.productDescription.text = '';
    productController.productName.text = '';
    productController.productPrice.text = '';
    productController.productAvailability.text = '';
    productController.productCategory = '';

  }

}
