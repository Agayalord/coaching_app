import 'api_client.dart';
import 'smart_coaching_api.dart';

class ServiceLocator {
  static final ApiClient _client = ApiClient(
    // IMPORTANT: use 10.0.2.2 for Android Emulator
    // baseUrl: 'http://10.0.2.2:8000',
    baseUrl: 'http://127.0.0.1:8000',
  );

  static final SmartCoachingApi api = SmartCoachingApi(_client);
}

// class ServiceLocator {
//   static const String baseUrl = 'http://127.0.0.1:8000';
//   static final auth = AuthApi(baseUrl);
// }
