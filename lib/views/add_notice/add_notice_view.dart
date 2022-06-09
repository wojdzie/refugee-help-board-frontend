import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';
import 'package:refugee_help_board_frontend/views/add_notice/components/add_notice_tile.dart';
import 'package:refugee_help_board_frontend/views/add_notice/components/export_notices_dialog.dart';
import 'package:tuple/tuple.dart';

part "add_notice_view.g.dart";

const baseNotice = Notice(description: "", tags: [], type: "XD");

@hcwidget
Widget addNoticeView(BuildContext context, WidgetRef ref) {
  final key = useMemoized(() => GlobalKey<FormState>());

  final selectedType = useState(requestType);
  final selectedFilters = useState(<String>[]);

  final nextId = useState(1);
  final noticesFormsData = useState([Tuple2(0, baseNotice.copyWith())]);

  final noticesWidgets = useMemoized(
      () => noticesFormsData.value.asMap().entries.map((entry) => AddNoticeTile(
            key: Key(entry.value.item1.toString()),
            count: entry.key + 1,
            onChange: (notice) {
              var idx = noticesFormsData.value
                  .indexWhere((tuple) => tuple.item1 == entry.value.item1);

              noticesFormsData.value
                ..removeAt(idx)
                ..insert(idx, Tuple2(entry.value.item1, notice));
            },
            onRemove: noticesFormsData.value.length != 1
                ? () {
                    noticesFormsData.value = [
                      ...noticesFormsData.value
                        ..removeWhere(
                            (value) => value.item1 == entry.value.item1)
                    ];
                  }
                : null,
          )),
      [noticesFormsData.value]);

  final isLoading = useState(false);

  final submitFunction = useCallback(() async {
    if (key.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adding notice(s)...')),
      );

      isLoading.value = true;

      final results = await Future.wait(noticesFormsData.value.map(
          (tuple) => ref.read(noticeApiProvider.notifier).post(tuple.item2)));

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      isLoading.value = false;

      final isSuccess =
          !results.map((result) => result.isSuccess).any((element) => false);

      if (isSuccess) {
        Navigator.of(context).pop();
      } else {
        var errors = results
            .where((result) => !result.isSuccess)
            .map((failure) => failure.error)
            .map((error) => error.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errors.toString())),
        );
      }
    }
  }, []);

  return Scaffold(
    appBar: AppBar(title: const Text("Add new notice(s)")),
    body: Form(
        key: key,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              ...noticesWidgets,
              const Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: const Text("Add next notice"),
                  onPressed: () {
                    noticesFormsData.value = [
                      ...noticesFormsData.value,
                      Tuple2(nextId.value, baseNotice.copyWith())
                    ];
                    nextId.value++;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        )),
    bottomNavigationBar: BottomAppBar(
        child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.restore),
            label: const Text("Restore"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Restore"),
                        content: const Text(
                            "Warning: Restoration from file will destroy your data. Do you want to proceed?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                try {
                                  var result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    print(result.files.single.path);
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "This operating system doesn't support restoration feature")),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No")),
                        ],
                      ));
            },
          ),
          const SizedBox(
            width: 12,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text("Save"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => const ExportNoticesDialog());
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: isLoading.value ? null : submitFunction,
            child: isLoading.value
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : const Text('Submit'),
          ),
        ],
      ),
    )),
  );
}
