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
  ReportStorage offersService = ReportStorage(name: "offers");
  ReportStorage requestsService = ReportStorage(name: "requests");

  ReportService(this.ref) : super(null);

  final Ref ref;

  Future<HttpResult<void, FetchFailures>> fetchOffers() async {
    try {
      final response = await ref.read(httpClient).get(serverAddress("/notice"));

      if (response.statusCode == 200) {
        offersService.writeContent(response.body);

        return HttpResult.success(null);
      } else {
        return HttpResult.failure(FetchFailures.systemError);
      }
    } catch (error) {
      return HttpResult.failure(FetchFailures.systemError);
    }
  }

  Future<HttpResult<void, FetchFailures>> fetchRequests() async {
    try {
      final response = await ref.read(httpClient).get(serverAddress("/notice"));

      if (response.statusCode == 200) {
        requestsService.writeContent(response.body);

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
