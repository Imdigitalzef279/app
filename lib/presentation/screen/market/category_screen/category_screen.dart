import 'package:flutter/material.dart';
import '../../../../data/dto/product/product.dart';
import '../../../../data/mock/product_data.dart';
import '../product_detail/product_detail_screen.dart';
import 'package:intl/intl.dart';
class CategoryScreen extends StatelessWidget {
  final String title;
  final int type;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.type,
  });

  List<Product> getProducts() {
    return allProducts
        .where((e) => e.categoryId == type)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = getProducts();


    print("TITLE = $title");
    print("TYPE = $type");
    print("COUNT = ${products.length}");
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
                  name: item.name,
                  price: item.price,
                  image: item.image,
                  description: item.description,
                  discount: item.discount,
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
  final int price;
  final String image;
  final String description;
  final double discount;

  static final NumberFormat currencyFormat =
  NumberFormat("#,###", "en_US");

  const _ProductItem({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.discount,
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
              description: description,
              discount: discount,
            )
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
                errorBuilder: (context, error, stackTrace) {
                  debugPrint("ERROR IMAGE = $image");
                  debugPrint(error.toString());

                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  );
                },
              ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            price > 0
                ? Text(

              "${currencyFormat.format(price)} đ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            )
                : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1ABC9C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Nhận báo giá",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}