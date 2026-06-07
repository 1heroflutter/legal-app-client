import 'package:client/features/personalization/models/judgment_model.dart';
import 'package:client/utils/http/http_client.dart';

class JudgmentRepository {
  /// Fetch a random list of judgments from the backend
  Future<List<JudgmentModel>> fetchRandomJudgments({int limit = 5}) async {
    try {
      final response = await THttpHelper.get('judgments/random?limit=$limit');
      
      final list = response['judgments'] as List<dynamic>? ?? [];
      
      return list
          .map((item) => JudgmentModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Lỗi khi tải bản án: $e');
    }
  }
}
