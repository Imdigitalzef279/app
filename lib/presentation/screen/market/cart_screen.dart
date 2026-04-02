import 'package:flutter/material.dart';
import '../../../data/dto/cart/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        centerTitle: true,
      ),
      body: Cart.items.isEmpty
          ? const Center(child: Text("Giỏ hàng trống"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: Cart.items.length,
              itemBuilder: (_, index) {
                final item = Cart.items[index];

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
                      /// IMAGE
                      Image.asset(
                        item.image,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image),
                          );
                        },
                      ),

                      const SizedBox(width: 12),

                      /// INFO
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("${item.price}đ"),
                          ],
                        ),
                      ),

                      /// ACTIONS
                      SizedBox(
                        width: 80,
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  Cart.increase(item);
                                });
                              },
                            ),
                            Text("${item.quantity}"),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  Cart.decrease(item);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  Cart.remove(item);
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          /// TOTAL
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Tổng: ${Cart.totalPrice}đ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}