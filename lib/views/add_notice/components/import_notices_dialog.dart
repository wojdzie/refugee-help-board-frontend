import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/utils/storage.dart';
import 'package:refugee_help_board_frontend/views/add_notice/add_notice_view.dart';
import 'package:tuple/tuple.dart';

part "import_notices_dialog.g.dart";

@hwidget
Widget importNoticesDialog(BuildContext context,
    {required void Function(List<NoticeField<int, Notice>>) onImport}) {
  final saveStorage = useMemoized(() => Storage(directory: "drafts"));
  final saveStorageFiles = useMemoized(() => saveStorage.listDirectory());

  final selectedFile = useState<String?>(null);
  final snapshot = useStream(saveStorageFiles);

  return AlertDialog(
    title: const Text("Restore"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Warning: Restoration from file will destroy data you worked on.",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text("List of saved notices:"),
        snapshot.hasData
            ? SizedBox(
                height: 200,
                width: 324,
                child: ListView(
                  children: snapshot.data!
                      .map((entity) => ListTile(
                            selected: entity.uri.pathSegments.last ==
                                selectedFile.value,
                            title: Text(entity.uri.pathSegments.last),
                            onTap: () {
                              selectedFile.value = entity.uri.pathSegments.last;
                            },
                          ))
                      .toList(),
                ))
            : const CircularProgressIndicator()
      ],
    ),
    actions: [
      TextButton(
          onPressed: () async {
            try {
              var result = await FilePicker.platform.pickFiles();

              if (result != null) {
                print(result.files.single.path);
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        "This operating system doesn't support file pick feature")),
              );
              Navigator.pop(context);
            }
          },
          child: const Text("Other file")),
      TextButton(
          onPressed: selectedFile.value != null
              ? () async {
                  final content =
                      await saveStorage.readFile(selectedFile.value!);

                  final type = selectedFile.value!.split(".").last;

                  var state = <NoticeField<int, Notice>>[];

                  if (type == "json") {
                    final notices = jsonDecode(content)
                        .map((notice) => Notice.fromJson(notice));

                    state = List<Notice>.from(notices)
                        .asMap()
                        .entries
                        .map((entry) => NoticeField(entry.key, entry.value))
                        .toList();
                  } else if (type == "csv") {
                  } else if (type == "xlsx") {}

                  onImport(state);

                  Navigator.pop(context);
                }
              : null,
          child: const Text("Restore")),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel")),
    ],
  );
}
