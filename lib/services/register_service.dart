import 'package:refugee_help_board_frontend/constants/backend.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';
import 'package:refugee_help_board_frontend/services/http_client.dart';

class RegisterService {
  static Future<Result> register(User user) async {
    final response = await httpClient.post(serverAddress("/user/register"),
        body: user.toJson());

    return response.statusCode == 200 ? Result.success : Result.failure;
  }
}
