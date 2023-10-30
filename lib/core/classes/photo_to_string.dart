import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shop/features/product/presentation/getx/product_controller.dart';

class PhotoToString{

  takeAPhotoFromGallery() async{

    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (pickedFile != null) {
      final bytes = File(pickedFile.path).readAsBytesSync();
      final picture = base64.encode(bytes);
      return picture;
      // if(photoOf == 'Equipment'){
      //   equipmentController.equipmentByteImage = base64.encode(bytes);
      // }

    }
  }

  takeMultiplePhotoFromGallery() async{

    ProductController productController = Get.find();
    final List<XFile> images = await ImagePicker().pickMultiImage(
      maxWidth: 400,
      maxHeight: 400,
    );
    for(var image in images){
      final bytes = File(image.path).readAsBytesSync();
      final picture = base64.encode(bytes);
      productController.listOfImages.add(picture);
    }
    }

}