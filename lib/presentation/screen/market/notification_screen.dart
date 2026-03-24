import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông báo"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 8, // fake data
        itemBuilder: (_, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Bạn có đơn hàng mới"),
            subtitle: const Text("Đơn hàng #123 đã được tạo"),
            trailing: const Text("10:30"),
          );
        },
      ),
    );
  }
}