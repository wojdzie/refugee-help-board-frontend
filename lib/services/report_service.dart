import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/constants/backend.dart';
import 'package:refugee_help_board_frontend/services/http_client.dart';

enum FetchFailures { systemError }

enum PostFailures { systemError }

class ReportService extends StateNotifier<void> {
  ReportService(this.ref) : super(null);

  final Ref ref;

  Future<HttpResult<Map<String, dynamic>, FetchFailures>>
      fetchOverview() async {
    try {
      final response =
          await ref.read(httpClient).get(serverAddress("/report/overview"));

      if (response.statusCode == 200) {
        return HttpResult.success(json.decode(response.body));
      } else {
        return HttpResult.failure(FetchFailures.systemError);
      }
    } catch (error) {
      return HttpResult.failure(FetchFailures.systemError);
    }
  }

  Future<HttpResult<Map<String, dynamic>, FetchFailures>> fetchPeriodic(
      DateTime? from, DateTime? to) async {
    try {
      final response = await ref.read(httpClient).get(serverAddress(
          "/report/periodic",
          {"from": from!.toIso8601String(), "to": to!.toIso8601String()}));

      if (response.statusCode == 200) {
        // reportStorage.writeFile("periodic", response.body, "json");

        return HttpResult.success(json.decode(response.body));
      } else {
        return HttpResult.failure(FetchFailures.systemError);
      }
    } catch (error) {
      return HttpResult.failure(FetchFailures.systemError);
    }
  }
}

final reportApiProvider = StateNotifierProvider((ref) => ReportService(ref));
