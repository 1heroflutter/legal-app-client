import 'package:client/utils/http/http_client.dart';

class ChatService {
  Future<String> sendMessage(String message) async {
    try {
      final response = await THttpHelper.post('chat', {'message': message});
      return response['answer'] ?? 'No answer received';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
