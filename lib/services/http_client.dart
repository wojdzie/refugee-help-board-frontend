import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:refugee_help_board_frontend/services/user_service.dart';

class _HttpClient extends BaseClient {
  _HttpClient(this.headers);

  final Map<String, String> headers;
  final client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);

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

final httpClient = Provider((ref) {
  final user = ref.watch(userProvider);

  final headers = <String, String>{};

  if (user != null) {
    final u8 = utf8.encode("${user.login}:${user.password}");
    final base64 = base64Encode(u8);

    headers["authentication"] = "Basic $base64";
  }

  final client = _HttpClient(headers);

  return client;
});
