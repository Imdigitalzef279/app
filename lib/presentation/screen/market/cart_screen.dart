import 'package:flutter/material.dart';
import '../../../data/dto/cart/cart.dart';
import 'checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        centerTitle: true,
      ),

      body: Cart.items.isEmpty
          ? _emptyCart()
          : Column(
        children: [

          /// LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: Cart.items.length,
              itemBuilder: (_, index) {
                final item = Cart.items[index];

                return _cartItem(item);
              },
            ),
          ),

          /// BOTTOM
          _bottomBar(),
        ],
      ),
    );
  }

  /// ================= ITEM =================
  Widget _cartItem(item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.image,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image, size: 50),
            ),
          ),

          const SizedBox(width: 12),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "${item.price}đ",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Column(
            children: [

              /// DELETE
              InkWell(
                onTap: () {
                  setState(() {
                    Cart.remove(item);
                  });
                },
                child: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 8),

              /// QUANTITY
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                  Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    _qtyBtn(Icons.remove, () {
                      setState(() {
                        Cart.decrease(item);
                      });
                    }),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      child: Text(
                        "${item.quantity}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    _qtyBtn(Icons.add, () {
                      setState(() {
                        Cart.increase(item);
                      });
                    }),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// ================= BUTTON +/- =================
  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16),
      ),
    );
  }

  /// ================= BOTTOM =================
  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Tổng tiền",
                style: TextStyle(fontSize: 14),
              ),
              const Spacer(),
              Text(
                "${Cart.totalPrice}đ",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: Cart.items.isEmpty
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const CheckoutScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1ABC9C),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Thanh toán",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// ================= EMPTY =================
  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart_outlined,
              size: 60, color: Colors.grey),
          SizedBox(height: 10),
          Text("Giỏ hàng trống"),
        ],
      ),
    );
  }
}