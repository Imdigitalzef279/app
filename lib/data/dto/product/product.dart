class Product {
  final String name;
  final int price;
  final String image;
  final int categoryId;
  final String description;
  final double discount;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.description,
    required this.discount,
    this.quantity = 1,
  });
}