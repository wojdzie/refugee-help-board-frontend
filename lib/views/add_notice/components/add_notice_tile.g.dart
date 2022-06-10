// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notice_tile.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class NumberedDivider extends StatelessWidget {
  const NumberedDivider({Key? key, required this.id}) : super(key: key);

  final num id;

  @override
  Widget build(BuildContext _context) => numberedDivider(id: id);
}

class AddNoticeTile extends HookWidget {
  const AddNoticeTile(
      {Key? key,
      required this.count,
      required this.data,
      required this.onChange,
      this.onRemove})
      : super(key: key);

  final int count;

  final Notice data;

  final void Function(Notice) onChange;

  final void Function()? onRemove;

  @override
  Widget build(BuildContext _context) => addNoticeTile(
      count: count, data: data, onChange: onChange, onRemove: onRemove);
}
