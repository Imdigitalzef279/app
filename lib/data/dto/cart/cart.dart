class CartItem {
  final String name;
  final int price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class Cart {
  static final List<CartItem> items = [];

  static void add(CartItem product) {
    final index =
    items.indexWhere((item) => item.name == product.name);

    if (index != -1) {
      items[index].quantity++;
    } else {
      items.add(product);
    }
  }

  static void increase(CartItem item) {
    item.quantity++;
  }

  static void decrease(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    }
  }

  static void remove(CartItem item) {
    items.remove(item);
  }

  static int get totalPrice {
    int total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}