import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/services/report_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part "periodic_report_view.g.dart";

@hcwidget
Widget periodicReport(BuildContext ctx, WidgetRef ref) {
  final key = useMemoized(() => GlobalKey<FormState>());

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
  }, [fromDate.value]);

  useEffect(() {
    if (toDate.value == null) {
      toController.text = "";
    } else {
      toController.text = toDate.value.toString().split(" ").first;
    }
  }, [toDate.value]);

  return Scaffold(
      appBar: AppBar(title: const Text("From: ")),
      body: Center(
          child: Form(
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
                                context: ctx,
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
                                context: ctx,
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
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please wait...')),
                                  );

                                  isLoading.value = true;

                                  final result = await ref
                                      .read(reportApiProvider.notifier)
                                      .fetchPeriodic(
                                          fromDate.value, toDate.value);

                                  ScaffoldMessenger.of(ctx)
                                      .hideCurrentSnackBar();
                                  isLoading.value = false;
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
              ))));
}
