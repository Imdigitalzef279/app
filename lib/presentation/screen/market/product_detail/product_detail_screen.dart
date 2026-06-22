import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ProductDetailScreen extends StatefulWidget {
  final String name;
  final int price;
  final String image;
  final String description;
  final double discount;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.discount,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  int get priceInt => widget.price;

  String formatPrice(int value) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(value).replaceAll(',', '.')} đ';
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPrice = widget.price > 0;
    final int discountPercent = (widget.discount * 100).toInt();
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

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: hasPrice
                          ? Colors.green.shade50
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      hasPrice
                          ? formatPrice(widget.price)
                          : "Liên hệ nhận báo giá",
                      style: TextStyle(
                        color: hasPrice
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                 Text(
                    "Phiếu giảm giá $discountPercent%",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text("Điểm tích lũy"),
                  const SizedBox(height: 20),

                  const Text(
                    "Thông tin sản phẩm",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
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
                              icon: const Icon(
                                Icons.add_circle,
                                size: 28,
                                color: Color(0xFF00A99D),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const Divider(),

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
            const Spacer(),

            SizedBox(
              width: 160,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A99D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Vui lòng liên hệ KRA Power để nhận báo giá"),
                    ),
                  );
                },
                child: Text(
                  hasPrice
                      ? formatPrice(widget.price)
                      : "Nhận báo giá",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
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