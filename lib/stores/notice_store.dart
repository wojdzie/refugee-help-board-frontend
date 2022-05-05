import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';

final noticesProvider = StateProvider<List<Notice>?>((ref) => null);
