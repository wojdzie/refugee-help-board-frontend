import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/services/report_service.dart';

part "report_view.g.dart";

@hcwidget
Widget reportView(BuildContext ctx, WidgetRef ref) => Scaffold(
    appBar: AppBar(title: const Text("Generate reports")),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Offers report"),
            onPressed: () async {
              await ref.read(reportApiProvider.notifier).fetchOffers();
            },
          ),
          ElevatedButton(
            child: const Text("Requests report"),
            onPressed: () async {
              await ref.read(reportApiProvider.notifier).fetchRequests();
            },
          ),
        ],
      ),
    ));
