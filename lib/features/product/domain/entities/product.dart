import 'dart:io';

class Product {
  int id;
  String name;
  String catagory;
  String description;
  double price;
  File? image;

  Product({
    required this.id,
    required this.name,
    required this.catagory,
    required this.description,
    required this.price,
    this.image,
  });
}
