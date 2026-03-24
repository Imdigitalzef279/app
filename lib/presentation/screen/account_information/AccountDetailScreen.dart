import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tài khoản")),
      body: const Center(child: Text("Account Detail")),
    );
  }
}