import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Giao diện")),
      body: const Center(child: Text("Theme Settings")),
    );
  }
}