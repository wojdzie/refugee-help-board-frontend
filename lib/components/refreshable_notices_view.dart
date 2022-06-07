import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/list_item.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';

part 'refreshable_notices_view.g.dart';

@cwidget
Widget refreshableNoticesView(BuildContext context, WidgetRef ref,
    {List<Notice>? notices}) {
  if (notices == null) {
    return const CircularProgressIndicator();
  }

  return RefreshIndicator(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.separated(
          itemCount: notices.length,
          itemBuilder: (ctx, index) =>
              ListItem(notice: notices[notices.length - 1 - index]),
          separatorBuilder: (ctx, index) => const Divider(),
        ),
      ),
      onRefresh: () => ref.read(noticeApiProvider.notifier).fetch());
}
