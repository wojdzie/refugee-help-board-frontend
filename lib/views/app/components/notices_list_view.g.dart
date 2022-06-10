// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notices_list_view.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class NoticesListView extends HookConsumerWidget {
  const NoticesListView({Key? key, required this.setOnRefresh})
      : super(key: key);

  final ValueNotifier<Future<void> Function()?> setOnRefresh;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      noticesListView(_context, _ref, setOnRefresh: setOnRefresh);
}
