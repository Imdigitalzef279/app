import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../product_detail/product_detail_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String title;
  final int type;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// HEADER
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// 🔥 BANNER
            Container(
              height: 180,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage("assets/images/banner.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// 🆕 TITLE
            const Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    "Sản phẩm mới",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ///  LIST PRODUCT
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 6,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final products = [
                  {
                    "name": "Xiaomi Pad 8 Pro",
                    "price": "16.990.000đ",
                    "image": "assets/images/device.png"
                  },
                  {
                    "name": "Smart Breaker",
                    "price": "2.000.000đ",
                    "image": "assets/images/device.png"
                  },
                ];

                return _ProductItem(
                  name: products[index]["name"]!,
                  price: products[index]["price"]!,
                  image: products[index]["image"]!,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
class _ProductItem extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const _ProductItem({
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              name: name,
              price: price,
              image: image,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.image, size: 50),
              ),
            ),
            const SizedBox(height: 6),
            Text(name),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}