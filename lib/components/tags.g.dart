// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class OfferTag extends StatelessWidget {
  const OfferTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => offerTag();
}

class ChoiceOfferTag extends StatelessWidget {
  const ChoiceOfferTag({Key? key, required this.selected, this.onSelected})
      : super(key: key);

  final bool selected;

  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext _context) =>
      choiceOfferTag(selected: selected, onSelected: onSelected);
}

class RequestTag extends StatelessWidget {
  const RequestTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => requestTag();
}

class ChoiceRequestTag extends StatelessWidget {
  const ChoiceRequestTag({Key? key, required this.selected, this.onSelected})
      : super(key: key);

  final bool selected;

  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext _context) =>
      choiceRequestTag(selected: selected, onSelected: onSelected);
}

class LawTag extends StatelessWidget {
  const LawTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => lawTag();
}

class FilterLawTag extends StatelessWidget {
  const FilterLawTag(
      {Key? key, required this.selected, required this.onSelected})
      : super(key: key);

  final bool selected;

  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext _context) =>
      filterLawTag(selected: selected, onSelected: onSelected);
}

class FoodTag extends StatelessWidget {
  const FoodTag({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext _context) => foodTag(label: label);
}

class FilterFoodTag extends StatelessWidget {
  const FilterFoodTag(
      {Key? key, required this.selected, required this.onSelected})
      : super(key: key);

  final bool selected;

  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext _context) =>
      filterFoodTag(selected: selected, onSelected: onSelected);
}

class AccomodationTag extends StatelessWidget {
  const AccomodationTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => accomodationTag();
}

class FilterAccomodationTag extends StatelessWidget {
  const FilterAccomodationTag(
      {Key? key, required this.selected, required this.onSelected})
      : super(key: key);

  final bool selected;

  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext _context) =>
      filterAccomodationTag(selected: selected, onSelected: onSelected);
}
