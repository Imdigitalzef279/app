import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/project/request/project_request.dart';
import 'package:solar_energy/data/dto/project/response/project_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/base_repository.dart';
import 'package:solar_energy/data/repositories/project/project_repository.dart';

class ProjectRepositoryImpl extends BaseRepository
    implements ProjectRepository {
  @override
  Future<Result<PaginationResponse<ProjectResponse>>> getProjects(
      ProjectRequest request) async {
    return callApiPagination(() => api.getProjects(request));
  }
}
