import 'package:flutter/material.dart';
import '../../../../domain/mcb/entities/mcb_entity.dart';

class McbControlPanel extends StatelessWidget {
  final McbEntity mcb;
  const McbControlPanel({super.key, required this.mcb});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _btn('ON'),
        _btn('OFF'),
        _btn('FORCE ON'),
      ],
    );
  }

  Widget _btn(String label) {
    return OutlinedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}

