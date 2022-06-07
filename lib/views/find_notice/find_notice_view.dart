import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/list_item.dart';
import 'package:refugee_help_board_frontend/components/refreshable_notices_view.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart';
import 'package:refugee_help_board_frontend/extenstions/string.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';
import 'package:refugee_help_board_frontend/stores/notice_store.dart';

part "find_notice_view.g.dart";

@hcwidget
Widget findNoticeView(BuildContext ctx, WidgetRef ref) {
  final filteredNotices = ref.watch(filteredNoticesProvider);

  final selectedType = useState(requestType);
  final selectedFilters = useState(<String>[]);

  useEffect(() {
    ref
        .read(noticeApiProvider.notifier)
        .fetchFiltered(selectedType.value, selectedFilters.value);

    return null;
  }, [selectedType.value, selectedFilters.value]);

  return MaterialApp(
      title: 'Notice finder',
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.indigo,
          unselectedWidgetColor: Colors.white,
          toggleableActiveColor: Colors.white,
          listTileTheme: const ListTileThemeData(textColor: Colors.white),
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all<Color>(Colors.indigo),
          )),
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          backgroundColor: Colors.indigo,
          title: const Text("Find notices"),
          leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          actions: const [
            BackdropToggleButton(icon: AnimatedIcons.ellipsis_search)
          ],
        ),
        subHeader: BackdropSubHeader(
            title: Text(filteredNotices != null
                ? "See ${filteredNotices.length} results"
                : "See results")),
        backLayer: ListView(children: [
          const ListTile(title: Text("Notice type:")),
          RadioListTile(
            title: Text(requestType.capitalize()),
            secondary: const Icon(
              Icons.handshake,
              color: Colors.white,
            ),
            value: requestType,
            groupValue: selectedType.value,
            onChanged: (String? selected) {
              selectedType.value = requestType;
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          RadioListTile(
            title: Text(offerType.capitalize()),
            secondary: const Icon(
              Icons.volunteer_activism,
              color: Colors.white,
            ),
            value: offerType,
            groupValue: selectedType.value,
            onChanged: (String? selected) {
              selectedType.value = offerType;
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const ListTile(title: Text("Tags:")),
          CheckboxListTile(
            title: Text(accomodationLabel.capitalize()),
            secondary: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            value: selectedFilters.value.contains(accomodationLabel),
            onChanged: (selected) {
              if (selected!) {
                selectedFilters.value = [
                  ...selectedFilters.value,
                  accomodationLabel
                ];
              } else {
                selectedFilters.value = selectedFilters.value
                    .where((filter) => filter != accomodationLabel)
                    .toList();
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text(foodLabel.capitalize()),
            secondary: const Icon(
              Icons.restaurant,
              color: Colors.white,
            ),
            value: selectedFilters.value.contains(foodLabel),
            onChanged: (selected) {
              if (selected!) {
                selectedFilters.value = [...selectedFilters.value, foodLabel];
              } else {
                selectedFilters.value = selectedFilters.value
                    .where((filter) => filter != foodLabel)
                    .toList();
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text(lawLabel.capitalize()),
            secondary: const Icon(
              Icons.gavel,
              color: Colors.white,
            ),
            value: selectedFilters.value.contains(lawLabel),
            onChanged: (selected) {
              if (selected!) {
                selectedFilters.value = [...selectedFilters.value, lawLabel];
              } else {
                selectedFilters.value = selectedFilters.value
                    .where((filter) => filter != lawLabel)
                    .toList();
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ]),
        frontLayer: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Center(
              child: RefreshableNoticesView(
            notices: filteredNotices,
          )),
        ),
      ));
}
