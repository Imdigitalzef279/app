import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';


Future<String?> showPasswordDialog(BuildContext context) {

  String pin = "";

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        title: const Text(
          "Nhập mã PIN",
          textAlign: TextAlign.center,
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Pinput(
              length: 4,
              obscureText: true,

              defaultPinTheme: PinTheme(
                width: 55,
                height: 55,
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),

              focusedPinTheme: PinTheme(
                width: 55,
                height: 55,
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue),
                ),
              ),

              onCompleted: (value) {
                pin = value;
              },
            ),

            const SizedBox(height: 12),

            const Text(
              "PIN mặc định: 9999",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            )
          ],
        ),

        actions: [

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Huỷ"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, pin);
            },
            child: const Text("Xác nhận"),
          )
        ],
      );
    },
  );
}