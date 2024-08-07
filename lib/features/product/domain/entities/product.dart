class Product {
  int id;
  String name;
  String? catagory;
  String description;
  double price;
  String image;

  Product({
    required this.id,
    required this.name,
    this.catagory,
    required this.description,
    required this.price,
    required this.image,
  });
}
