import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/refreshable_notices_view.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';
import 'package:refugee_help_board_frontend/stores/notice_store.dart';

part 'notices_list_view.g.dart';

@hcwidget
Widget noticesListView(BuildContext context, WidgetRef ref) {
  final notices = ref.watch(noticesProvider);

  useEffect(() {
    ref.read(noticeApiProvider.notifier).fetch();

    return null;
  }, []);

  return Center(
      child: RefreshableNoticesView(
    notices: notices,
  ));
}
