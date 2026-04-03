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

  ///  DATA THEO TYPE
  List<Map<String, String>> getProducts() {
    if (type == 1) {
      ///  ACREL
      return [
        {
          "name": "Acrel Device 1",
          "price": "3.000.000đ",
          "image":
          "assets/images/acrel/1446074178112364544_08557473-8d6a-46ec-96a2-a1c7ca71168e.webp"
        },
        {
          "name": "Acrel Device 2",
          "price": "4.500.000đ",
          "image":
          "assets/images/acrel/1446074178112364544_ab28e10d-d177-4106-b705-3bb6dd6644bb.webp"
        },
        {
          "name": "Acrel Device 3",
          "price": "5.200.000đ",
          "image":
          "assets/images/acrel/1446074178112364544_acfcbf40-6a2a-4da4-8739-567915c07d1d.webp"
        },
      ];
    } else {
      ///  MATIS
      return [
        {
          "name": "Matis Device 1",
          "price": "2.000.000đ",
          "image": "assets/images/matis/1.png"
        },
        {
          "name": "Matis Device 2",
          "price": "2.500.000đ",
          "image": "assets/images/matis/2.png"
        },
        {
          "name": "Matis Device 3",
          "price": "3.200.000đ",
          "image": "assets/images/matis/4.png"
        },
        {
          "name": "Matis Device 4",
          "price": "4.000.000đ",
          "image": "assets/images/matis/5.png"
        },
        {
          "name": "Matis System",
          "price": "6.000.000đ",
          "image": "assets/images/matis/Enertrek System.png"
        },
        {
          "name": "Matis Banner",
          "price": "1.500.000đ",
          "image": "assets/images/matis/ảnh bìa.png"
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = getProducts();

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

            ///  BANNER
            Container(
              height: 180,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage("assets/images/backgrounds/ảnh bìa.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// TITLE
            const Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    "Sản phẩm",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// GRID PRODUCT
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: products.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = products[index];

                return _ProductItem(
                  name: item["name"]!,
                  price: item["price"]!,
                  image: item["image"]!,
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
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}