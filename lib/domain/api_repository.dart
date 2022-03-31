import '../common/network/api_service.dart';
import '../common/models/api_response.dart';
import '../data/models/fact.dart';

class ApiRepository {
  final _provider = ApiService();

  Future<ApiResponse<Fact>> fetchFact() {
    return _provider.fetchData();
  }
}
