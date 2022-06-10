// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ListItem extends HookConsumerWidget {
  const ListItem({Key? key, required this.notice, required this.onRefresh})
      : super(key: key);

  final Notice notice;

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      listItem(_ref, notice: notice, onRefresh: onRefresh);
}
