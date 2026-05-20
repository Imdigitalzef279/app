import 'package:get_it/get_it.dart';
import '../../data_sources/api/api_client.dart';
import '../../dto/meter_config/request/meter_config_request.dart';
import '../../dto/meter_config/response/meter_config_response.dart';
import 'meter_config_repository.dart';

class MeterConfigRepositoryImpl implements MeterConfigRepository {
  final _api = GetIt.instance<ApiClient>();

  @override
  Future<List<MeterConfigResponse>> getConfigs(
      int meterId,
      ) async {
    final res = await _api.getMeterConfigByMeterId(meterId);

    return res;
  }

  @override
  Future<MeterConfigResponse> saveConfig(
      MeterConfigRequest request) async {

    print("====== POST METER CONFIG ======");
    print("BODY: ${request.toJson()}");

    try {
      final res = await _api.createMeterConfig(request);

      print("====== RESPONSE SUCCESS ======");
      print(res.toJson());

      return res;

    } catch (e) {
      print("====== RESPONSE ERROR ======");
      print(e);
      rethrow;
    }
  }
  @override
  @override
  Future<void> saveConfigs(
      List<MeterConfigRequest> configs,
      ) async {

    print("====== SAVE CONFIGS ======");

    try {

      /// load config hiện tại
      final currentConfigs =
      await getConfigs(configs.first.meterId);

      for (final config in configs) {

        print("BODY: ${config.toJson()}");
        print("CURRENT CONFIGS:");

        for (final c in currentConfigs) {
          print("${c.id} - ${c.configKey}");
        }
        /// tìm config đã tồn tại
        final exist = currentConfigs.where(
              (e) =>

          e.configKey
              .trim()
              .toLowerCase()

              ==

              config.configKey
                  .trim()
                  .toLowerCase(),
        );

        /// UPDATE
        if (exist.isNotEmpty) {

          final old = exist.first;

          await _api.updateMeterConfig(
            old.id,
            config,
          );
          print("UPDATE ID: ${old.id}");
          print("UPDATED: ${config.configKey}");
          print("FOUND CONFIG: ${old.configKey}");
        }

        /// CREATE
        // else {
        //
        //
        //   final res =
        //   await _api.createMeterConfig(config);
        //
        //   print(res.toJson());
        //   print("CREATED: ${config.configKey}");
        // }
    /// CREATE
    else {

    print(
    "CONFIG NOT FOUND: ${config.configKey}",
    );

    continue;
    }
      }

      print("====== SAVE DONE ======");

    } catch (e) {

      print("====== SAVE ERROR ======");
      print(e);

      rethrow;
    }
  }
}