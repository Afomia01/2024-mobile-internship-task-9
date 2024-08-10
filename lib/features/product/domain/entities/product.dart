class Product {
  String id;
  String name;
  String? catagory;
  String description;
  double price;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    this.catagory,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
