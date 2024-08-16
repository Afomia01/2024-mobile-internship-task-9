import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

// import '../../domain/entities/product.dart';

// class ProductModel extends Product {
//   const ProductModel({
//     required super.id,
//     required super.name,
//     required super.description,
//     required super.price,
//     required super.imageUrl,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'] ?? '',  // Provide default values if null
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       price: (json['price'] ?? 0.0).toDouble(),  // Ensure price is a double
//       imageUrl: json['image'] ?? '',  // Match key with toJson
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'price': price,
//       'image': imageUrl,  // Match key with fromJson
//     };
//   }
// }
