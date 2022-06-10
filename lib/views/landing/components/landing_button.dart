import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'landing_button.g.dart';

@swidget
Widget landingButton(BuildContext context,
        {required String label,
        required String route,
        required IconData icon}) =>
    Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: ElevatedButton.icon(
          style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 48))),
          label: Text(label),
          icon: Icon(icon),
          onPressed: () => Navigator.pushNamed(context, route),
        ));
