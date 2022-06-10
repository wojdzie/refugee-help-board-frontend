import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/components/tags.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';
import 'package:refugee_help_board_frontend/services/notice_service.dart';
import 'package:refugee_help_board_frontend/stores/user_store.dart';

part "list_item.g.dart";

enum Menu { addToCalendar, removeItem }

@hcwidget
Widget listItem(
  WidgetRef ref, {
  required Notice notice,
  required Future<void> Function() onRefresh,
}) {
  final user = ref.watch(userProvider);

  final menuItems = useMemoized(() {
    final items = [
      PopupMenuItem(
        value: Menu.addToCalendar,
        child: const Text("Add to calendar"),
        onTap: () {
          final creationDate = DateTime.parse(notice.creationData!);
          final event = Event(
            title: 'Refugee app: event',
            description: notice.description,
            startDate: creationDate,
            endDate: creationDate.add(const Duration(hours: 1)),
          );

          Add2Calendar.addEvent2Cal(event);
        },
      )
    ];

    if (notice.author == user?.login && !notice.closed!) {
      items.add(PopupMenuItem(
        value: Menu.removeItem,
        child: const Text(
          "Complete item",
          style: TextStyle(color: Colors.green),
        ),
        onTap: () async {
          await ref.read(noticeApiProvider.notifier).close(notice);
          onRefresh();
        },
      ));
    }

    return items;
  }, [notice, user]);

  if (user == null) {
    return const CircularProgressIndicator();
  }

  return ListTile(
      contentPadding: const EdgeInsets.all(12),
      trailing:
          PopupMenuButton(itemBuilder: (BuildContext context) => menuItems),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(notice.description),
      ),
      subtitle: Column(children: [
        const SizedBox(
          height: 16,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: notice.type == offerType
                ? const OfferTag()
                : const RequestTag()),
        notice.tags.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                      children: notice.tags.map((tag) {
                    switch (tag) {
                      case accomodationLabel:
                        return const AccomodationTag();
                      case foodLabel:
                        return const FoodTag();
                      case lawLabel:
                        return const LawTag();
                      default:
                        return Container();
                    }
                  }).toList())
                ],
              )
            : Container(),
        notice.closed!
            ? Column(children: const [
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CompletedTag(),
                )
              ])
            : Container()
      ]));
}
