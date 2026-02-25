import 'automat_ui_model.dart';

class AutomatFactoryGroup {
  final String factoryId;
  final String factoryName;
  final List<AutomatUIModel> devices;

  const AutomatFactoryGroup({
    required this.factoryId,
    required this.factoryName,
    required this.devices,
  });
}
