import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thanh toán"),
      ),
      body: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Địa chỉ giao hàng"),
            subtitle: Text("Chưa chọn"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.payment),
            title: Text("Phương thức thanh toán"),
            subtitle: Text("Thanh toán khi nhận hàng"),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Đặt hàng thành công"),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text("Đặt hàng"),
              ),
            ),
          )
        ],
      ),
    );
  }
}