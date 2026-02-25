class McbEntity {
  final String id;
  final String name;
  final bool isOnline;

  final double ratedCurrent;
  final double current;

  final List<double> phaseVoltage; // Ua Ub Uc
  final List<double> phaseCurrent; // Ia Ib Ic

  final double power;   // kW
  final double energy;  // kWh

  McbEntity({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.ratedCurrent,
    required this.current,
    required this.phaseVoltage,
    required this.phaseCurrent,
    required this.power,
    required this.energy,
  });
}
