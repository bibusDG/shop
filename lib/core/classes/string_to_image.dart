import 'dart:convert';
import 'package:flutter/material.dart';

class StringToImage{
  final List<String>? listOfImage;
  final String? image;
  const StringToImage({
    this.image,
    this.listOfImage
});

  Image getSingleImage({image}){
    final myImage = Image(image: Image.memory(const Base64Decoder().convert(image)).image,);
    return myImage;
  }

  List<Image> getListOfImage({listOfImage}){
      List<Image> images = [];
      for(var value in listOfImage){
        images.add(Image(image: Image.memory(const Base64Decoder().convert(value)).image));
      }
      return images;


  }

}