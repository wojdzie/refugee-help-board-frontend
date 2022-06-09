import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:refugee_help_board_frontend/constants/backend.dart';
import 'package:refugee_help_board_frontend/services/http_client.dart';

enum FetchFailures { systemError }

enum PostFailures { systemError }

class ReportStorage {
  String name;

  ReportStorage({required this.name});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$name.json');
  }

  Future<File> writeContent(String content) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(content);
  }
}

class ReportService extends StateNotifier<void> {
  ReportStorage overviewService = ReportStorage(name: "Overiview");
  ReportStorage periodicService = ReportStorage(name: "Periodic");

  ReportService(this.ref) : super(null);

  final Ref ref;

  Future<HttpResult<void, FetchFailures>> fetchOverview() async {
    try {
      final response =
          await ref.read(httpClient).get(serverAddress("/report/overview"));

      if (response.statusCode == 200) {
        overviewService.writeContent(response.body);

        return HttpResult.success(null);
      } else {
        return HttpResult.failure(FetchFailures.systemError);
      }
    } catch (error) {
      return HttpResult.failure(FetchFailures.systemError);
    }
  }

  Future<HttpResult<void, FetchFailures>> fetchPeriodic(
      DateTime? from, DateTime? to) async {
    try {
      final response = await ref.read(httpClient).get(serverAddress(
          "/report/periodic",
          {"from": from!.toIso8601String(), "to": to!.toIso8601String()}));

      if (response.statusCode == 200) {
        periodicService.writeContent(response.body);

        return HttpResult.success(null);
      } else {
        return HttpResult.failure(FetchFailures.systemError);
      }
    } catch (error) {
      return HttpResult.failure(FetchFailures.systemError);
    }
  }
}

final reportApiProvider = StateNotifierProvider((ref) => ReportService(ref));
