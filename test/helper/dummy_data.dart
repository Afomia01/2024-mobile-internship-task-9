// dummy_data.dart

import 'dart:convert';

import 'package:myapp/features/product/data/model/product_model.dart';

final dummyProducts = [
  const ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 9.99,
    imageUrl: 'http://example.com/image1.jpg',
  ),
  const ProductModel(
    id: '2',
    name: 'Product 2',
    description: 'Description 2',
    price: 19.99,
    imageUrl: 'http://example.com/image2.jpg',
  ),
];

String get dummyProductsJson => json.encode(
      dummyProducts.map((product) => product.toJson()).toList(),
    );
var dummy_data = {
  'data': dummyProducts,
  'message': 'Products fetched successfully',
  'statusCode': 200
};

List<ProductModel> parseDummyProducts() {
  return (json.decode(dummyProductsJson) as List)
      .map((data) => ProductModel.fromJson(data))
      .toList();
}
