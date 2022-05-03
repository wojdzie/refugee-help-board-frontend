import 'package:http/http.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';

class _HttpClient extends BaseClient {
  final client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers["authorization"] = "Basic ";
    request.headers["Content-Type"] = "application/json; charset=utf-8";

    return client.send(request);
  }
}

class HttpResult<T, E> {
  T? data;
  E? error;
  bool isSuccess;

  HttpResult(this.data, this.error, this.isSuccess);

  HttpResult.success(this.data)
      : error = null,
        isSuccess = true;
  HttpResult.failure(this.error)
      : data = null,
        isSuccess = false;
}

final httpClient = _HttpClient();
