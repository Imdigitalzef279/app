import 'package:flutter/material.dart';
import '../../../../domain/mcb/entities/mcb_entity.dart';

class McbRealtimeCards extends StatelessWidget {
  final McbEntity mcb;
  const McbRealtimeCards({super.key, required this.mcb});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: [
        _card('Ua', '${mcb.phaseVoltage[0]} V'),
        _card('Ub', '${mcb.phaseVoltage[1]} V'),
        _card('Uc', '${mcb.phaseVoltage[2]} V'),
        _card('Ia', '${mcb.phaseCurrent[0]} A'),
        _card('Ib', '${mcb.phaseCurrent[1]} A'),
        _card('Ic', '${mcb.phaseCurrent[2]} A'),
        _card('Energy', '${mcb.energy} kWh'),
      ],
    );
  }

  Widget _card(String title, String value) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

