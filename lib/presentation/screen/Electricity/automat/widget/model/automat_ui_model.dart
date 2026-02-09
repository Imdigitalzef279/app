enum AutomatStatus { normal, warning, error, off }

class PhaseValue {
  final double a;
  final double b;
  final double c;

  const PhaseValue({
    required this.a,
    required this.b,
    required this.c,
  });
}

class AutomatUIModel {
  final String id;
  final String name;
  final String type;

  final double ratedCurrent; // A
  final double current; // A
  final double loadPercent; // %

  final PhaseValue voltage; // V
  final PhaseValue currentPhase; // A

  final AutomatStatus status;

  const AutomatUIModel({
    required this.id,
    required this.name,
    required this.type,
    required this.ratedCurrent,
    required this.current,
    required this.loadPercent,
    required this.voltage,
    required this.currentPhase,
    required this.status,
  });
}
