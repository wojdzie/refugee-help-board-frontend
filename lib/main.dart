import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/views/add_notice/add_notice_view.dart';
import 'package:refugee_help_board_frontend/views/find_notice/find_notice_view.dart';
import 'package:refugee_help_board_frontend/views/landing/landing_view.dart';
import 'package:refugee_help_board_frontend/views/app/app_view.dart';
import 'package:refugee_help_board_frontend/views/login/login_view.dart';
import 'package:refugee_help_board_frontend/views/register/register_view.dart';
part 'main.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

@swidget
Widget myApp(BuildContext ctx) => MaterialApp(
        title: "Refugee App",
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          "/": (context) => const LandingView(),
          "/register": (context) => const RegisterView(),
          "/login": (context) => const LoginView(),
          "/app": (context) => const AppView(),
          "/add-notice": (context) => const AddNoticeView(),
          "/find-notice": (context) => const FindNoticeView(),
        });
