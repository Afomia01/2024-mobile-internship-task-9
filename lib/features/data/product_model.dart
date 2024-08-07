import '../product/domain/entities/product.dart';

class ProductModel extends Product {
   ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      price: json['price'],
      image: (json['imageUrl']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
