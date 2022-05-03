import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/stores/user_store.dart';

part "list_view.g.dart";

@cwidget
Widget appView(WidgetRef ref) {
  final user = ref.watch(userProvider);

  return Scaffold(
      appBar: AppBar(title: const Text("Refugee App")),
      body: Center(
          child: Column(
        children: [
          Text("Login: ${user!.login}"),
          Text("Password: ${user.password}"),
          Text("Email: ${user.email}")
        ],
      )));
}
