import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/components/tags.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';

part "add_notice_tile.g.dart";

@swidget
Widget numberedDivider({required num id}) => Row(children: [
      const Expanded(
        child: Divider(),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Notice $id",
            style: const TextStyle(color: Colors.grey),
          )),
      const Expanded(
        child: Divider(),
      ),
    ]);

@hwidget
Widget addNoticeTile(
    {required int count,
    required Notice data,
    required void Function(Notice) onChange,
    void Function()? onRemove}) {
  final descriptionController = useTextEditingController();

  final selectedType = useState(requestType);
  final selectedFilters = useState(<String>[]);
  final description = useValueListenable(descriptionController);

  final updateFields = useCallback(
      () => onChange(Notice(
          description: descriptionController.text,
          type: selectedType.value,
          tags: selectedFilters.value)),
      [descriptionController.text, selectedType.value, selectedFilters.value]);

  useEffect(() {
    print("change");

    return null;
  }, [description, selectedType.value, selectedFilters.value]);

  useEffect(() {
    print("Update");
    descriptionController.text = data.description;
    selectedType.value = data.type;
    selectedFilters.value = data.tags;

    return null;
  }, [data]);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 24),
      NumberedDivider(id: count),
      TextFormField(
        controller: descriptionController,
        onChanged: (value) {
          updateFields();
        },
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          labelText: 'Description',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Description can\'t be empty';
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
                updateFields();
              }),
          const SizedBox(width: 12),
          ChoiceOfferTag(
              selected: selectedType.value == offerType,
              onSelected: (bool selected) {
                selectedType.value = offerType;
                updateFields();
              }),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
        children: [
          FilterAccomodationTag(
              selected: selectedFilters.value.contains(accomodationLabel),
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
                updateFields();
              }),
          const SizedBox(width: 12),
          FilterFoodTag(
              selected: selectedFilters.value.contains(foodLabel),
              onSelected: (selected) {
                if (selected) {
                  selectedFilters.value = [...selectedFilters.value, foodLabel];
                } else {
                  selectedFilters.value = selectedFilters.value
                      .where((filter) => filter != foodLabel)
                      .toList();
                }
                updateFields();
              }),
          const SizedBox(width: 12),
          FilterLawTag(
              selected: selectedFilters.value.contains(lawLabel),
              onSelected: (selected) {
                if (selected) {
                  selectedFilters.value = [...selectedFilters.value, lawLabel];
                } else {
                  selectedFilters.value = selectedFilters.value
                      .where((filter) => filter != lawLabel)
                      .toList();
                }
                updateFields();
              }),
        ],
      ),
      const SizedBox(height: 12),
      onRemove != null
          ? ElevatedButton.icon(
              label: const Text("Remove this notice"),
              icon: const Icon(Icons.remove),
              onPressed: onRemove,
              style: ElevatedButton.styleFrom(
                  primary: Colors.red, onPrimary: Colors.white))
          : Container(),
      const SizedBox(height: 24),
    ],
  );
}
