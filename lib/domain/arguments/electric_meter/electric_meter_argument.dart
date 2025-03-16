import 'package:solar_energy/application/enums/electric_type.dart';

import '../../../data/dto/project/response/project_response.dart';

class ElectricMeterArgument{
  final ElectricType type;
  final ProjectResponse project;

  const ElectricMeterArgument({required this.type, required this.project});
}