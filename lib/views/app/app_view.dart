import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/services/user_service.dart';
import 'package:refugee_help_board_frontend/stores/user_store.dart';
import 'package:refugee_help_board_frontend/views/app/components/notices_list_view.dart';
import 'package:refugee_help_board_frontend/views/app/components/profile_view.dart';

part "app_view.g.dart";

enum AppPages { noticesList, profile }

@hcwidget
Widget appView(BuildContext ctx, WidgetRef ref) {
  final user = ref.watch(userProvider);
  final userApi = ref.watch(userApiProvider.notifier);
  final currentPage = useState(AppPages.noticesList);

  if (user == null) {
    return CircularProgressIndicator();
  }

  return Scaffold(
    drawer: Drawer(
        child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(user.login),
          accountEmail: user.email != null ? Text(user.email!) : null,
          currentAccountPicture:
              const CircleAvatar(child: Icon(Icons.person_outline, size: 48)),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF42A5F5),
              Color(0xFF1976D2),
              Color(0xFF0D47A1),
            ],
          )),
        ),
        ListTile(
          title: const Text('Notices list'),
          leading: const Icon(Icons.list),
          selected: currentPage.value == AppPages.noticesList,
          onTap: () {
            currentPage.value = AppPages.noticesList;
          },
        ),
        ListTile(
          title: const Text('Account'),
          leading: const Icon(Icons.account_circle),
          selected: currentPage.value == AppPages.profile,
          onTap: () {
            currentPage.value = AppPages.profile;
          },
        ),
        Expanded(flex: 1, child: Container()),
        const Divider(),
        ListTile(
          title: const Text('Log out'),
          leading: const Icon(Icons.logout),
          onTap: () {
            userApi.logout();
            Navigator.of(ctx).pushNamedAndRemoveUntil("/", (_) => false);
          },
        ),
      ],
    )),
    appBar: AppBar(
      title: Text(currentPage.value == AppPages.noticesList
          ? "List of notices"
          : "Update profile"),
      actions: [
        currentPage.value == AppPages.noticesList
            ? IconButton(
                onPressed: () {
                  Navigator.of(ctx).pushNamed("/find-notice");
                },
                icon: const Icon(Icons.search))
            : Container()
      ],
    ),
    body: currentPage.value == AppPages.noticesList
        ? const NoticesListView()
        : const ProfileView(),
    floatingActionButton: currentPage.value == AppPages.noticesList
        ? FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(ctx).pushNamed("/add-notice");
            },
          )
        : Container(),
  );
}
