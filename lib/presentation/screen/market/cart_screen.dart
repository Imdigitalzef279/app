import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 5, // fake data
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 5)
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade300,
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tên sản phẩm",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Giá: 1.000.000đ"),
                    ],
                  ),
                ),

                Column(
                  children: [
                    const Icon(Icons.add),
                    const Text("1"),
                    const Icon(Icons.remove),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}