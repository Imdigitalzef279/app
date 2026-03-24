import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hướng dẫn sử dụng")),
      body: const Center(child: Text("Guide")),
    );
  }
}