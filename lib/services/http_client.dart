import 'package:http/http.dart';

class _HttpClient extends BaseClient {
  final client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers["authorization"] = "Basic ";

    return client.send(request);
  }
}

enum Result { success, failure }

final httpClient = _HttpClient();
