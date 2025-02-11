import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/project/request/project_request.dart';
import 'package:solar_energy/data/dto/project/response/project_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';

abstract class ProjectRepository {
  Future<Result<PaginationResponse<ProjectResponse>>> getProjects(
      ProjectRequest request);
}
