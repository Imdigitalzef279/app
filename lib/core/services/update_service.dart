import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateService {
  static Future<void> checkUpdate(BuildContext context) async {
    try {
      final info = await InAppUpdate.checkForUpdate();

      if (info.updateAvailability == UpdateAvailability.updateAvailable) {


        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Cập nhật ứng dụng"),
            content: const Text("Có phiên bản mới, bạn có muốn cập nhật không?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Để sau"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);


                  await InAppUpdate.performImmediateUpdate();
                },
                child: const Text("Cập nhật"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("Update error: $e");
    }
  }
}