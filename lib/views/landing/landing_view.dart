import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part "landing_view.g.dart";

@swidget
Widget landingView(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text("Refugee App")),
    body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 120),
          child: Text(
            "Thank you for help",
            style: Theme.of(ctx).textTheme.headline5,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () => Navigator.pushNamed(ctx, "/register"),
                ),
                ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () => Navigator.pushNamed(ctx, "/login"),
                ),
              ],
            ))
      ],
    )));
