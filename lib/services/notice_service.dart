import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/constants/backend.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';
import 'package:refugee_help_board_frontend/services/http_client.dart';
import 'package:refugee_help_board_frontend/stores/notice_store.dart';
import 'package:refugee_help_board_frontend/stores/user_store.dart';

enum FetchFailures { systemError }

class _NoticeService extends StateNotifier<void> {
  _NoticeService(this.ref) : super(null);

  final Ref ref;

  Future<HttpResult<void, FetchFailures>> fetch() async {
    try {
      final response = await ref.read(httpClient).get(serverAddress("/notice"));

      if (response.statusCode == 200) {
        final iterable =
            jsonDecode(response.body).map((notice) => Notice.fromJson(notice));

        ref
            .read(noticesProvider.notifier)
            .update((state) => List<Notice>.from(iterable));

        return HttpResult.success(null);
      } else {
        return HttpResult.failure(FetchFailures.systemError);
      }
    } catch (error) {
      return HttpResult.failure(FetchFailures.systemError);
    }
  }
}

final noticeApiProvider = StateNotifierProvider((ref) => _NoticeService(ref));
