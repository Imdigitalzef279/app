import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet {
  static Future<dynamic> showBottomSheet(BuildContext context,
      {required Widget child, bool isScroll = true, double? height}) async {
    return showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: isScroll,
        builder: (BuildContext context) {
          return SizedBox(width: 1.sw, height: height, child: child);
        });
  }
}
