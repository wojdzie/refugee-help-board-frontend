import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/refreshable_notices_view.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';
import 'package:refugee_help_board_frontend/stores/notice_store.dart';

part 'profile_notices_list_view.g.dart';

@hcwidget
Widget profileNoticesListView(BuildContext context, WidgetRef ref) {
  final notices = useState<List<Notice>?>(null);

  final onRefresh = useCallback(() async {
    final result = await ref.read(noticeApiProvider.notifier).fetchPersonal();

    if (result.isSuccess) {
      notices.value = result.data;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Problem with fetching notices')),
      );
    }
  }, []);

  useEffect(() {
    onRefresh();

    return null;
  }, []);

  return Center(
      child: RefreshableNoticesView(
    notices: notices.value,
    onRefresh: onRefresh,
  ));
}
