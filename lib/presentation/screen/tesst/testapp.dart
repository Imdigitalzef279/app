import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/constants/localizations.dart';

class TestAppWareHouse extends StatelessWidget {
  const TestAppWareHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 200.w,
              height: 1.sh /2,
              color: Colors.amber,
              child: Text(
            LocalizationsUtils.localizations.helloWorld,
            style: TextStyle(
                fontFamily: 'BeVietNamPro',
                fontSize: 20.sp,
                fontWeight: FontWeight.w900),
          )),
        ),
      ),
    );
  }
}
