import 'package:client/utils/http/http_client.dart';

class ChatService {
  Future<String> sendMessage(String message) async {
    try {
      final response = await THttpHelper.post('chat', {'message': message});
      return response['answer'] ?? 'No answer received';
    } catch (e) {
      // Làm sạch chuỗi lỗi, loại bỏ tiền tố 'Exception:' của Dart để thân thiện với người dùng
      final cleanMsg = e.toString().replaceAll('Exception: ', '').trim();
      return cleanMsg.isNotEmpty ? cleanMsg : '⚠️ Đã xảy ra lỗi kết nối. Vui lòng kiểm tra mạng và thử lại!';
    }
  }
}
