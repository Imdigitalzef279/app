import 'package:flutter/material.dart';
import '../../../../data/dto/product/product.dart';
import '../../../../data/mock/product_data.dart';
import '../product_detail/product_detail_screen.dart';

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
              "${price.toString()} đ",
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