import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/features/data/product_model.dart'; // Update this with the correct path to your model

void main() {
  final productModel = ProductModel(
    id: 1,
    name: 'Test Product',
    description: 'A product for testing',
    price: 19.99,
    image: 'http://example.com/image.jpg',
  );

  final Map<String, dynamic> jsonMap = {
    'id': 1,
    'title': 'Test Product',
    'description': 'A product for testing',
    'price': 19.99,
    'imageUrl': 'http://example.com/image.jpg',
  };

  test('should create a ProductModel from JSON', () {
    // Act
    final result = ProductModel.fromJson(jsonMap);

    // Assert
    expect(result, isA<ProductModel>());
    expect(result.id, productModel.id);
    expect(result.name, productModel.name);
    expect(result.description, productModel.description);
    expect(result.price, productModel.price);
    expect(result.image, productModel.image);
  });

  test('should convert a ProductModel to JSON', () {
    // Act
    final result = productModel.toJson();

    // Assert
    final expectedJsonMap = {
      'id': 1,
      'name': 'Test Product',
      'description': 'A product for testing',
      'price': 19.99,
      'image': 'http://example.com/image.jpg',
    };

    expect(result, expectedJsonMap);
  });
}
