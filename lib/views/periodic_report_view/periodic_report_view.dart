import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/services/report_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:refugee_help_board_frontend/utils/storage.dart';

part "periodic_report_view.g.dart";

@hcwidget
Widget periodicReport(BuildContext context, WidgetRef ref) {
  final key = useMemoized(() => GlobalKey<FormState>());
  var reportStorage = useMemoized(() => Storage(directory: "report"));

  final periodicData = useState<Map<String, dynamic>?>(null);

  final fromController = useTextEditingController();
  final toController = useTextEditingController();

  final toDate = useState<DateTime?>(null);
  final fromDate = useState<DateTime?>(null);

  final isLoading = useState(false);

  useEffect(() {
    if (fromDate.value == null) {
      fromController.text = "";
    } else {
      fromController.text = fromDate.value.toString().split(" ").first;
    }

    return null;
  }, [fromDate.value]);

  useEffect(() {
    if (toDate.value == null) {
      toController.text = "";
    } else {
      toController.text = toDate.value.toString().split(" ").first;
    }

    return null;
  }, [toDate.value]);

  return Scaffold(
      appBar: AppBar(title: const Text("Generate periodic report")),
      body: Center(
          child: Column(children: [
        Form(
            key: key,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: fromController,
                    decoration: const InputDecoration(
                      labelText: 'From: ',
                    ),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2023))
                          .then((value) => fromDate.value = value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'From can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: toController,
                    decoration: const InputDecoration(
                      labelText: 'To: ',
                    ),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2023))
                          .then((value) => toDate.value = value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'To can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: isLoading.value
                          ? null
                          : () async {
                              if (key.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please wait...')),
                                );

                                isLoading.value = true;

                                final result = await ref
                                    .read(reportApiProvider.notifier)
                                    .fetchPeriodic(
                                        fromDate.value, toDate.value);

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                isLoading.value = false;

                                if (result.isSuccess) {
                                  periodicData.value = result.data;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('System error')),
                                  );
                                }
                              }
                            },
                      child: isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Submit'),
                    ),
                  ),
                ],
              ),
            )),
        periodicData.value != null
            ? Expanded(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    Text(
                      "In total:",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 48),
                    Text(
                      "Requests created: ${periodicData.value!['requests']['total']}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      "Requests closed: ${periodicData.value!['requests']['closed']}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 48),
                    Text(
                      "Offers created: ${periodicData.value!['offers']['total']}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      "Offers closed: ${periodicData.value!['offers']['closed']}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 48),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 48))),
                          label: const Text("Save data"),
                          icon: const Icon(Icons.save),
                          onPressed: () {
                            reportStorage.writeFile("overview",
                                json.encode(periodicData.value), "json");

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Report saved successfully')),
                            );
                          },
                        ))
                  ])))
            : Container()
      ])));
}
