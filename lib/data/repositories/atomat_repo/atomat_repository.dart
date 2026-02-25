import 'package:solar_energy/data/dto/atomat/atomat_log_response.dart';
import 'package:solar_energy/data/dto/atomat/atomat_request.dart';


abstract class AtomatRepository {
  Future<List<AtomatLogResponse>> getLogAtomat(AtomatRequest request);
}
