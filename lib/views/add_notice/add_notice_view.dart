import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/tags.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';

part "add_notice_view.g.dart";

@hcwidget
Widget addNoticeView(BuildContext ctx, WidgetRef ref) {
  final key = useMemoized(() => GlobalKey<FormState>());

  final descriptionController = useTextEditingController();
  final selectedType = useState(requestType);
  final selectedFilters = useState(<String>[]);

  final isLoading = useState(false);

  return Scaffold(
      appBar: AppBar(title: const Text("Add new notice")),
      body: Form(
          key: key,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: descriptionController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Login can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    ChoiceRequestTag(
                        selected: selectedType.value == requestType,
                        onSelected: (bool selected) {
                          selectedType.value = requestType;
                        }),
                    const SizedBox(width: 12),
                    ChoiceOfferTag(
                        selected: selectedType.value == offerType,
                        onSelected: (bool selected) {
                          selectedType.value = offerType;
                        }),
                  ],
                ),
                Row(
                  children: [
                    FilterAccomodationTag(
                        selected:
                            selectedFilters.value.contains(accomodationLabel),
                        onSelected: (selected) {
                          if (selected) {
                            selectedFilters.value = [
                              ...selectedFilters.value,
                              accomodationLabel
                            ];
                          } else {
                            selectedFilters.value = selectedFilters.value
                                .where((filter) => filter != accomodationLabel)
                                .toList();
                          }
                        }),
                    const SizedBox(width: 12),
                    FilterFoodTag(
                        selected: selectedFilters.value.contains(foodLabel),
                        onSelected: (selected) {
                          if (selected) {
                            selectedFilters.value = [
                              ...selectedFilters.value,
                              foodLabel
                            ];
                          } else {
                            selectedFilters.value = selectedFilters.value
                                .where((filter) => filter != foodLabel)
                                .toList();
                          }
                        }),
                    const SizedBox(width: 12),
                    FilterLawTag(
                        selected: selectedFilters.value.contains(lawLabel),
                        onSelected: (selected) {
                          if (selected) {
                            selectedFilters.value = [
                              ...selectedFilters.value,
                              lawLabel
                            ];
                          } else {
                            selectedFilters.value = selectedFilters.value
                                .where((filter) => filter != lawLabel)
                                .toList();
                          }
                        }),
                  ],
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
                                    content: Text('Adding notice...')),
                              );

                              isLoading.value = true;

                              final notice = Notice(
                                  description: descriptionController.text,
                                  type: selectedType.value,
                                  tags: selectedFilters.value);

                              final result = await ref
                                  .read(noticeApiProvider.notifier)
                                  .post(notice);

                              ScaffoldMessenger.of(ctx).hideCurrentSnackBar();

                              isLoading.value = false;

                              if (result.isSuccess) {
                                Navigator.of(ctx).pop();
                              } else {
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                  SnackBar(
                                      content: Text(result.error.toString())),
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
          )));
}
