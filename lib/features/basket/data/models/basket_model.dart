import 'dart:convert';

import 'package:shop/features/basket/domain/entities/basket.dart';

import '../../../product/domain/entities/product.dart';

class BasketModel extends Basket{
  const BasketModel({required super.basketContent});

  const BasketModel.empty() : this(
    basketContent: const [],
  );

  BasketModel copyWith({
    List<Product>? basketContent,
  }) => BasketModel(basketContent: basketContent ?? this.basketContent);

  factory BasketModel.fromRawJson(String str) => BasketModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BasketModel.fromJson(Map<String, dynamic> json) => BasketModel(
    basketContent: List<Product>.from(json["basketContent"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "basketContent": List<dynamic>.from(basketContent.map((x) => x)),
  };

}