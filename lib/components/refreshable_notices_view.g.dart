// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refreshable_notices_view.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class RefreshableNoticesView extends ConsumerWidget {
  const RefreshableNoticesView(
      {Key? key, this.notices, required this.onRefresh})
      : super(key: key);

  final List<Notice>? notices;

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      refreshableNoticesView(_context, _ref,
          notices: notices, onRefresh: onRefresh);
}
