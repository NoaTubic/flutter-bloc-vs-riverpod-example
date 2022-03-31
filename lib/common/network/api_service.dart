import 'package:dio/dio.dart';
import '../models/api_response.dart';
import '../../data/models/fact.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _url = 'https://uselessfacts.jsph.pl/random.json?language=en';

  Future<ApiResponse<Fact>> fetchData() async {
    try {
      Response response = await _dio.get(_url);
      return ApiResponse(
        data: Fact.fromJson(response.data),
      );
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");

      return ApiResponse(
        success: false,
        error: "Data not found / Connection issue",
      );
    }
  }
}
