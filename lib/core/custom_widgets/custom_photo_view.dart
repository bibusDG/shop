import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CustomPhotoView extends StatelessWidget{
  final List galleryItems;
  const CustomPhotoView({super.key,
    required this.galleryItems,
  });
  @override
  Widget build(BuildContext context) {
    if(galleryItems.isNotEmpty){
      return PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: galleryItems[index].image,
            initialScale: PhotoViewComputedScale.covered,
            // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
          );
        },
        itemCount: galleryItems.length,
        loadingBuilder: (context, event) => Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(value: event?.expectedTotalBytes != null
                ? event!.cumulativeBytesLoaded /
                event.expectedTotalBytes!
                : null,),
          ),
        ),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        // pageController: widget.pageController,
        // onPageChanged: onPageChanged,
      );
    }else{
      return const Center(child: Text('Brak zdjęć'));
    }

  }
}