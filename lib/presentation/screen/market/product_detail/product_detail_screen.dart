import 'package:flutter/material.dart';
import '../../../../data/dto/cart/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final int price;
  final String image;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  int get priceInt => widget.price;

  String formatPrice(int value) {
    return value
        .toString()
        .replaceAllMapped(RegExp(r'(\d{3})(?=(\d{3})+(?!\d))'),
            (Match m) => "${m[1]}.") +
        " đ";
  }

  @override
  Widget build(BuildContext context) {
    final total = priceInt * quantity;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// APPBAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.name),
        actions: const [
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),

      /// BODY
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE SLIDER
            Container(
              color: Colors.white,
              height: 300,
              child: PageView(
                children: [
                  Image.asset(widget.image, fit: BoxFit.contain),
                  Image.asset(widget.image, fit: BoxFit.contain),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// PRODUCT INFO
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// NAME
                  Text(widget.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 8),

                  /// PRICE
                  Row(
                    children: [
                      Text(
                        formatPrice(priceInt),
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "20.490.000 đ",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text("Phiếu giảm giá 12%"),
                  const Text("Mi Point tích lũy"),

                  const SizedBox(height: 20),

                  /// QUANTITY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Số lượng"),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text("$quantity"),
                            IconButton(
                              onPressed: () {
                                setState(() => quantity++);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const Divider(),

                  /// TOTAL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tổng cộng",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        formatPrice(total),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// REVIEW
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Đánh giá",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  _buildReview("Camellia", "Máy mượt, rất hài lòng", 5),
                  _buildReview("User123", "Giá tốt, đáng mua", 5),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// WHY BUY
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Tại sao nên mua",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  _WhyItem(icon: Icons.local_shipping, text: "Giao hàng nhanh"),
                  _WhyItem(icon: Icons.refresh, text: "Đổi trả 14 ngày"),
                  _WhyItem(icon: Icons.security, text: "Thanh toán an toàn"),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      ///  BOTTOM BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                formatPrice(total),
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  final product = CartItem(
                    name: widget.name,
                    price: priceInt,
                    image: widget.image,
                  );

                  Cart.add(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Đã thêm vào giỏ hàng")),
                  );
                },
                child: const Text("Thêm vào giỏ hàng"),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// REVIEW ITEM
  Widget _buildReview(String name, String content, int star) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
                star,
                    (index) => const Icon(Icons.star,
                    size: 14, color: Colors.orange)),
          ),
          Text(content),
        ],
      ),
    );
  }
}

/// WHY ITEM
class _WhyItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _WhyItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}