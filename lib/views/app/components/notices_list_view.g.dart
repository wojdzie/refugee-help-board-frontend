// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notices_list_view.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class NoticesListView extends HookConsumerWidget {
  const NoticesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context, WidgetRef _ref) => noticesListView(_ref);
}

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.notice}) : super(key: key);

  final Notice notice;

  @override
  Widget build(BuildContext _context) => listItem(notice: notice);
}
