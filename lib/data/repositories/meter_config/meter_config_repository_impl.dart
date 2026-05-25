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

    final res =
    await _api.getMeterConfigByMeterId(meterId);

    print("====== RAW GET CONFIG ======");
    print(res);

    /// api trả object có items
    if (res is Map<String, dynamic>) {

      final items = res['items'] ?? [];

      return (items as List)
          .map(
            (e) => MeterConfigResponse.fromJson(e),
      )
          .toList();
    }

    /// api trả list trực tiếp
    if (res is List) {

      return res
          .map(
            (e) => MeterConfigResponse.fromJson(e),
      )
          .toList();
    }

    return [];
  }

  @override
  Future<MeterConfigResponse> saveConfig(
      MeterConfigRequest request) async {

    print("====== POST METER CONFIG ======");
    print("BODY: ${request.toJson()}");

    try {
      final res = await _api.createMeterConfig(request);

      print("====== RESPONSE SUCCESS ======");


      return res;

    } catch (e) {
      print("====== RESPONSE ERROR ======");
      print(e);
      rethrow;
    }
  }
  @override
  Future<void> saveConfigs(
      List<MeterConfigRequest> configs,
      ) async {

    print("====== SAVE CONFIGS ======");

    try {

      // /// load config hiện tại
      // final currentConfigs =
      // await getConfigs(configs.first.meterId);
      print("TYPE:");
      // print(currentConfigs.runtimeType);
      //
      // for (final e in currentConfigs) {
      //
      //   print(e);
      //   print(e.runtimeType);
      // }
      for (final config in configs) {
        /// reload mỗi lần save
        final currentConfigs =
        await getConfigs(config.meterId);
        print("BODY: ${config.toJson()}");
        print("CURRENT CONFIGS:");

        for (final c in currentConfigs) {
          print("${c.id} - ${c.configKey}");
        }
        final old = currentConfigs.firstWhere(
              (e) => e.configKey == config.configKey,
          orElse: () => const MeterConfigResponse(),
        );
        /// UPDATE
        if (old.id != 0) {

          try {

            final res = await _api.updateMeterConfig(
              old.id,
              config,
            );

            print("====== UPDATE SUCCESS ======");
            print("UPDATE ID: ${old.id}");
            print("STATUS OK");
            print(res);

          } catch (e) {

            print("====== UPDATE ERROR ======");
            print("UPDATE ID: ${old.id}");
            print("CONFIG: ${config.toJson()}");
            print(e);

            rethrow;
          }
          print("UPDATE ID: ${old.id}");
          print("UPDATED: ${config.configKey}");
          print("FOUND CONFIG: ${old.configKey}");
        }

        else {

          try {

            final res =
            await _api.createMeterConfig(config);

            print("====== CREATE SUCCESS ======");
            print("CREATED: ${config.configKey}");

          } catch (e) {

            print("====== CREATE ERROR ======");
            print("CONFIG: ${config.toJson()}");
            print(e);

            rethrow;
          }
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