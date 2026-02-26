import 'package:flutter/material.dart';

Future<String?> showPasswordDialog(BuildContext context) async {
  final controller = TextEditingController();

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Xác thực"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscureText: true,
          textAlign: TextAlign.center,
          style: const TextStyle(
            letterSpacing: 12,
            fontSize: 20,
          ),
          decoration: const InputDecoration(
            hintText: "Nhập mã PIN 4 số",
            counterText: "",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.length != 4) return;
              Navigator.pop(context, controller.text);
            },
            child: const Text("Xác nhận"),
          ),
        ],
      );
    },
  );
}