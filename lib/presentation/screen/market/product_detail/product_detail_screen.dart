import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/dto/cart/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.white,
      ),

      body: Column(
        children: [

          /// IMAGE
          Expanded(
            child: PageView(
              children: [
                Image.asset(image),
                Image.asset(image),
              ],
            ),
          ),

          /// INFO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text("Phiếu giảm giá 12%"),
                const Text("Mi Point tích lũy"),

                const SizedBox(height: 20),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final product = CartItem(
                        name: name,
                        price: int.parse(price.replaceAll('.', '').replaceAll('đ', '')),
                        image: image,
                      );

                      Cart.add(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Đã thêm vào giỏ hàng")),
                      );
                    },
                    child: const Text("Thêm vào giỏ hàng"),
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}