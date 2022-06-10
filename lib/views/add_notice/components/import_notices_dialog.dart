import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/utils/storage.dart';
import 'package:refugee_help_board_frontend/views/add_notice/add_notice_view.dart';

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
              await FilePicker.platform.pickFiles();
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
                  final type = selectedFile.value!.split(".").last;

                  var state = <NoticeField<int, Notice>>[];

                  if (type == "json") {
                    final notices = jsonDecode(
                            await saveStorage.readFile(selectedFile.value!))
                        .map((notice) => Notice.fromJson(notice));

                    state = List<Notice>.from(notices)
                        .asMap()
                        .entries
                        .map((entry) => NoticeField(entry.key, entry.value))
                        .toList();
                  } else if (type == "csv") {
                    const detector = FirstOccurrenceSettingsDetector(
                        eols: ['\r\n', '\n'], textDelimiters: ['"', "'"]);
                    final notices = const CsvToListConverter(
                            csvSettingsDetector: detector)
                        .convert(
                            await saveStorage.readFile(selectedFile.value!));

                    List<String> parseArray(String csv) {
                      return csv
                          .substring(1, csv.length - 1)
                          .replaceAll(" ", "")
                          .split(",");
                    }

                    for (int i = 1; i < notices.length; i++) {
                      state.add(NoticeField(
                          i - 1,
                          Notice(
                            description: notices[i][0],
                            type: notices[i][1],
                            tags: parseArray(notices[i][2]),
                          )));
                    }
                  } else if (type == "xlsx") {
                    final excel = Excel.decodeBytes(
                        await saveStorage.readFileAsBytes(selectedFile.value!));

                    List<String> parseArray(String csv) {
                      return csv
                          .substring(1, csv.length - 1)
                          .replaceAll(" ", "")
                          .split(",");
                    }

                    final sheet = excel.sheets.values.first;

                    for (final row in sheet.rows..removeAt(0)) {
                      state.add(NoticeField(
                          state.length,
                          Notice(
                            description: row[0]!.value,
                            type: row[1]!.value,
                            tags: parseArray(row[2]!.value),
                          )));
                    }
                  }

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
