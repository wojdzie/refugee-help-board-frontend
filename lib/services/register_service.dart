import 'dart:convert';

import 'package:refugee_help_board_frontend/constants/backend.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';
import 'package:refugee_help_board_frontend/services/http_client.dart';

enum RegisterFailures { usernameTaken, systemError }

class RegisterService {
  static Future<HttpResult<User, RegisterFailures>> register(User user) async {
    try {
      print("r1");

      final response = await httpClient.post(serverAddress("/user/register"),
          body: jsonEncode(user.toJson()));

      print("r2");

      return response.statusCode == 200
          ? HttpResult.success(User.fromJson(jsonDecode(response.body)))
          : HttpResult.failure(RegisterFailures.usernameTaken);
    } catch (error) {
      return HttpResult.failure(RegisterFailures.systemError);
    }
  }
}
