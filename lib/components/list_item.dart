import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/components/tags.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart';
import 'package:refugee_help_board_frontend/schemas/notice/notice_schema.dart';

part "list_item.g.dart";

@swidget
Widget listItem({required Notice notice}) => ListTile(
    contentPadding: const EdgeInsets.all(12),
    title: Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(notice.description),
    ),
    subtitle: Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child:
              notice.type == offerType ? const OfferTag() : const RequestTag()),
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
    ]));
