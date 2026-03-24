import 'package:flutter/material.dart';

class ProductSearchDelegate extends SearchDelegate {

  /// fake data trước
  final List<String> products = [
    "Cầu dao thông minh",
    "Đồng hồ điện",
    "Thiết bị môi trường",
    "Gateway",
    "KRA Smart Safety",
    "Heat Pump",
  ];

  /// nút clear
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  /// nút back
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  /// kết quả search
  @override
  Widget buildResults(BuildContext context) {
    final result = products
        .where((e) => e.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildList(result);
  }

  /// gợi ý khi đang gõ
  @override
  Widget buildSuggestions(BuildContext context) {
    final result = products
        .where((e) => e.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildList(result);
  }

  Widget _buildList(List<String> list) {
    if (list.isEmpty) {
      return const Center(child: Text("Không tìm thấy"));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: const Icon(Icons.search),
          title: Text(list[index]),
          onTap: () {
            query = list[index];
          },
        );
      },
    );
  }
}