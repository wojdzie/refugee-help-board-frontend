import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/list_item.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';
import 'package:refugee_help_board_frontend/stores/notice_store.dart';

part 'notices_list_view.g.dart';

@hcwidget
Widget noticesListView(WidgetRef ref) {
  final notices = ref.watch(noticesProvider);
  final noticeApi = ref.watch(noticeApiProvider.notifier);

  useEffect(() {
    noticeApi.fetch();

    return null;
  }, []);

  return Center(
      child: notices != null
          ? RefreshIndicator(
              child: ListView.separated(
                itemCount: notices.length,
                itemBuilder: (ctx, index) =>
                    ListItem(notice: notices[notices.length - 1 - index]),
                separatorBuilder: (ctx, index) => const Divider(),
              ),
              onRefresh: () => noticeApi.fetch())
          : const CircularProgressIndicator());
}