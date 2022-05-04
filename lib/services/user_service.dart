import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/constants/backend.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';
import 'package:refugee_help_board_frontend/services/http_client.dart';

enum LoginFailures {
  wrongPassword("Wrong password"),
  systemError("System error");

  final String errorMessage;
  const LoginFailures(this.errorMessage);

  @override
  String toString() => errorMessage;
}

enum RegisterFailures {
  userAlreadyExists("User already exists"),
  systemError("System error");

  final String errorMessage;
  const RegisterFailures(this.errorMessage);

  @override
  String toString() => errorMessage;
}

class _UserService extends StateNotifier<User?> {
  _UserService(this.ref) : super(null);

  final Ref ref;

  Future<HttpResult<void, RegisterFailures>> register(User user) async {
    try {
      final response = await ref.read(httpClient).post(
          serverAddress("/user/register"),
          body: jsonEncode(user.toJson()));

      if (response.statusCode == 200) {
        state = user;

        return HttpResult.success(null);
      } else {
        return HttpResult.failure(RegisterFailures.userAlreadyExists);
      }
    } catch (error) {
      return HttpResult.failure(RegisterFailures.systemError);
    }
  }

  Future<HttpResult<void, LoginFailures>> login(User user) async {
    try {
      final response = await ref.read(httpClient).post(
          serverAddress("/user/authenticate"),
          body: jsonEncode(user.toJson()));

      if (response.statusCode == 200) {
        state = User.fromJson(jsonDecode(response.body));

        return HttpResult.success(null);
      } else {
        return HttpResult.failure(LoginFailures.wrongPassword);
      }
    } catch (error) {
      return HttpResult.failure(LoginFailures.systemError);
    }
  }
}

final userProvider =
    StateNotifierProvider<_UserService, User?>((ref) => _UserService(ref));
