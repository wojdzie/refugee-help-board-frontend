import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/refreshable_notices_view.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart';
import 'package:refugee_help_board_frontend/extenstions/string.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';

part "find_notice_view.g.dart";

@hcwidget
Widget findNoticeView(BuildContext context, WidgetRef ref) {
  final notices = useState<List<Notice>?>(null);

  final selectedType = useState(requestType);
  final selectedFilters = useState(<String>[]);

  final onRefresh = useCallback(() async {
    final result = await ref
        .read(noticeApiProvider.notifier)
        .fetchFiltered(selectedType.value, selectedFilters.value);

    if (result.isSuccess) {
      notices.value = result.data;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Problem with fetching notices')),
      );
    }
  }, []);

  useEffect(() {
    onRefresh();

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
        revealBackLayerAtStart: true,
        appBar: BackdropAppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: const Text("Find notices"),
          leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          actions: const [
            BackdropToggleButton(icon: AnimatedIcons.ellipsis_search)
          ],
        ),
        subHeader: BackdropSubHeader(
            title: Text(notices.value != null
                ? "See ${notices.value!.length} results"
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
            notices: notices.value,
            onRefresh: onRefresh,
          )),
        ),
      ));
}
