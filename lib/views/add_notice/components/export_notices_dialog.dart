import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/utils/storage.dart';

part "export_notices_dialog.g.dart";

const exportOptions = ["json", "csv", "xlsx"];

@hwidget
Widget exportNoticesDialog(BuildContext context,
    {required List<Notice> notices}) {
  final filenameController = useTextEditingController();
  final saveStorage = useMemoized(() => Storage(directory: "drafts"));

  final exportType = useState(0);

  return AlertDialog(
    title: const Text("Save"),
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text("Please provide filename for your export file:"),
      TextField(
        controller: filenameController,
        decoration: const InputDecoration(labelText: "Filename"),
      ),
      const SizedBox(height: 20),
      ToggleButtons(
        children: exportOptions.map((option) => Text(".$option")).toList(),
        isSelected: List.generate(exportOptions.length, (index) => false)
          ..removeAt(exportType.value)
          ..insert(exportType.value, true),
        onPressed: (selected) {
          exportType.value = selected;
        },
      ),
    ]),
    actions: [
      TextButton(
          onPressed: () async {
            if (exportOptions[exportType.value] == "json") {
              var json =
                  jsonEncode(notices.map((notice) => notice.toJson()).toList());

              await saveStorage.writeFile(filenameController.text, json,
                  exportOptions[exportType.value]);
            } else if (exportOptions[exportType.value] == "csv") {
              final csv = const ListToCsvConverter().convert([
                ["description", "type", "tags"],
                ...notices.map(
                    (notice) => [notice.description, notice.type, notice.tags])
              ]);

              await saveStorage.writeFile(filenameController.text, csv,
                  exportOptions[exportType.value]);
            } else if (exportOptions[exportType.value] == "xlsx") {
              const sheetName = "Refugee App draft";

              final excel = Excel.createExcel();
              excel.rename("Sheet1", sheetName);

              final sheet = excel[sheetName];

              sheet
                  .cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 0))
                  .value = "description";
              sheet
                  .cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 1))
                  .value = "type";
              sheet
                  .cell(CellIndex.indexByColumnRow(rowIndex: 0, columnIndex: 2))
                  .value = "tags";

              for (int i = 0; i < notices.length; i++) {
                sheet
                    .cell(CellIndex.indexByColumnRow(
                        rowIndex: i + 1, columnIndex: 0))
                    .value = notices[i].description;

                sheet
                    .cell(CellIndex.indexByColumnRow(
                        rowIndex: i + 1, columnIndex: 1))
                    .value = notices[i].type;

                sheet
                    .cell(CellIndex.indexByColumnRow(
                        rowIndex: i + 1, columnIndex: 2))
                    .value = notices[i].tags;
              }

              final xslx = excel.encode()!;

              await saveStorage.writeFileAsBytes(filenameController.text, xslx,
                  exportOptions[exportType.value]);
            } else {
              throw Exception(
                  "Unimplemented export type, this shouldn't happen");
            }

            final directory = await saveStorage.localDirectory;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Saved in ${directory.path}')),
            );
            Navigator.pop(context);
          },
          child: const Text("Save")),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel")),
    ],
  );
}
