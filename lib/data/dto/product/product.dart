class Product {
  final String name;
  final int price;
  final String image;
  final int categoryId;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
    this.quantity = 1,
  });
}