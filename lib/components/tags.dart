import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/constants/notice.dart';
import 'package:refugee_help_board_frontend/constants/tags.dart' as labels;

part "tags.g.dart";

@swidget
Widget offerTag() => const Chip(
      avatar: Icon(
        Icons.volunteer_activism,
        size: 16,
      ),
      label: Text(offerType),
      backgroundColor: Colors.lightGreenAccent,
    );

@swidget
Widget choiceOfferTag(
        {required bool selected, void Function(bool)? onSelected}) =>
    ChoiceChip(
      avatar: const Icon(
        Icons.volunteer_activism,
        size: 16,
      ),
      label: const Text(offerType),
      selected: selected,
      selectedColor: Colors.lightGreenAccent,
      onSelected: onSelected,
    );

@swidget
Widget requestTag() => const Chip(
    avatar: Icon(
      Icons.handshake,
      size: 16,
    ),
    label: Text(requestType),
    backgroundColor: Colors.lightBlueAccent);

@swidget
Widget choiceRequestTag(
        {required bool selected, void Function(bool)? onSelected}) =>
    ChoiceChip(
      avatar: const Icon(
        Icons.handshake,
        size: 16,
      ),
      label: const Text(requestType),
      selected: selected,
      selectedColor: Colors.lightBlueAccent,
      onSelected: onSelected,
    );

@swidget
Widget lawTag() => Container(
    margin: const EdgeInsets.only(right: 8),
    child: const Chip(
      avatar: Icon(
        Icons.gavel,
        size: 16,
      ),
      label: Text(labels.lawLabel),
    ));

@swidget
Widget filterLawTag(
        {required bool selected, required void Function(bool)? onSelected}) =>
    FilterChip(
      label: const Text(labels.lawLabel),
      selected: selected,
      onSelected: onSelected,
    );

@swidget
Widget foodTag() => Container(
    margin: const EdgeInsets.only(right: 8),
    child: const Chip(
      avatar: Icon(
        Icons.restaurant,
        size: 16,
      ),
      label: Text(labels.foodLabel),
    ));

@swidget
Widget filterFoodTag(
        {required bool selected, required void Function(bool)? onSelected}) =>
    FilterChip(
      label: const Text(labels.foodLabel),
      selected: selected,
      onSelected: onSelected,
    );

@swidget
Widget accomodationTag() => Container(
    margin: const EdgeInsets.only(right: 8),
    child: const Chip(
      avatar: Icon(
        Icons.home,
        size: 16,
      ),
      label: Text(labels.accomodationLabel),
    ));

@swidget
Widget filterAccomodationTag(
        {required bool selected, required void Function(bool)? onSelected}) =>
    FilterChip(
      label: const Text(labels.accomodationLabel),
      selected: selected,
      onSelected: onSelected,
    );
