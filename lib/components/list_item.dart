import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/components/tags.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';

part "list_item.g.dart";

enum Menu { addToCalendar }

@swidget
Widget listItem({required Notice notice}) => ListTile(
    contentPadding: const EdgeInsets.all(12),
    trailing: notice.creationData != null
        ? PopupMenuButton(
            onSelected: (xd) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
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
                  ),
                ])
        : null,
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
          child:
              notice.type == offerType ? const OfferTag() : const RequestTag()),
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
          : Container()
    ]));
