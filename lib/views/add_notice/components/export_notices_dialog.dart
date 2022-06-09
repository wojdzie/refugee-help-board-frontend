import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part "export_notices_dialog.g.dart";

const exportOptions = ["json", "csv", "xslx"];

@hwidget
Widget exportNoticesDialog(BuildContext context) {
  final filenameController = useTextEditingController();

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
      TextButton(onPressed: () {}, child: const Text("Save")),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel")),
    ],
  );
}
