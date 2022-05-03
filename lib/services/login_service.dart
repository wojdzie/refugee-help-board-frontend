import 'dart:convert';

import 'package:refugee_help_board_frontend/constants/backend.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';
import 'package:refugee_help_board_frontend/services/http_client.dart';

enum LoginFailures { wrongPassword, systemError }

class LoginService {
  static Future<HttpResult<User, LoginFailures>> login(User user) async {
    try {
      final response = await httpClient.post(
          serverAddress("/user/authenticate"),
          body: jsonEncode(user.toJson()));

      return response.statusCode == 200
          ? HttpResult.success(User.fromJson(jsonDecode(response.body)))
          : HttpResult.failure(LoginFailures.wrongPassword);
    } catch (error) {
      print(error);
      return HttpResult.failure(LoginFailures.systemError);
    }
  }
}
