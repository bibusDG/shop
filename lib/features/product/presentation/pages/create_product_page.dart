import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/classes/photo_to_string.dart';
import 'package:shop/core/classes/string_to_image.dart';
import 'package:shop/core/custom_widgets/custom_app_bar.dart';
import 'package:shop/core/custom_widgets/custom_text_form_field.dart';
import 'package:shop/features/product/presentation/getx/product_controller.dart';

class CreateProductPage extends GetView<ProductController> {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0), child: CustomAppBar(
            appBarTitle: controller.editProduct == false? 'Nowy produkt/${controller.productCategory}': 'Edutuj produkt')),
        body: Center(
          child: Obx(() {
            return SingleChildScrollView(
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
                      child: controller.editProduct == false?  Text('Dodaj zdjęcia produktu') : Text('Zmień zdjęcia'),
                      onPressed: () async {
                    controller.listOfImageString.value = [];
                    await PhotoToString().takeMultiplePhotoFromGallery();
                  }),
                  const SizedBox(height: 20.0),
                  controller.listOfImageString.isNotEmpty ?
                  Column(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 150,
                        child: ListView.builder(
                            itemExtent: 100,
                            itemCount: controller.listOfImageString.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<Image> myImages = const StringToImage().getListOfImage(listOfImage: controller.listOfImageString);
                              return Card(
                                child: Image(image: myImages[index].image,),
                              );
                            }),

                      ),
                      const SizedBox(height: 20.0,),
                    ],
                  )
                      :
                  const SizedBox(),
                  CupertinoButton(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      child: controller.editProduct == false?  Text('Utwórz nowy produkt') : Text('Zmień dane'),
                      onPressed: () async {
                        if(controller.editProduct == false){
                          await controller.addProduct();
                          await controller.resetCreateProductTextFields();
                        }else{
                          await controller.updateProduct();
                          await controller.resetCreateProductTextFields();
                        }
                        ///TODO depend on controller.editProduct -> add product or modify product

                  }),
                  const  SizedBox(height: 20.0,),

                ],
              ),
            );
          }),
        ),
    );
  }
}
