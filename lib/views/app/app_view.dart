import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/schemas/arguments/add_notice_arguments.dart';
import 'package:refugee_help_board_frontend/services/user_service.dart';
import 'package:refugee_help_board_frontend/stores/user_store.dart';
import 'package:refugee_help_board_frontend/views/app/components/notices_list_view.dart';
import 'package:refugee_help_board_frontend/views/app/components/profile_notices_list_view.dart';
import 'package:refugee_help_board_frontend/views/app/components/profile_view.dart';

part "app_view.g.dart";

enum AppPages { noticesList, profile }

@hcwidget
Widget appView(BuildContext context, WidgetRef ref) {
  final user = ref.watch(userProvider);

  final currentPage = useState(AppPages.noticesList);
  final currentNoticesList = useState(0);

  final onRefresh = useState<Future<void> Function()?>(null);

  if (user == null) {
    return const CircularProgressIndicator();
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
            ref.read(userApiProvider.notifier).logout();
            Navigator.of(context).pushNamedAndRemoveUntil("/", (_) => false);
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
                  Navigator.of(context).pushNamed("/find-notice");
                },
                icon: const Icon(Icons.search))
            : Container()
      ],
    ),
    body: currentPage.value == AppPages.noticesList
        ? currentNoticesList.value == 0
            ? NoticesListView(setOnRefresh: onRefresh)
            : ProfileNoticesListView(setOnRefresh: onRefresh)
        : const ProfileView(),
    bottomNavigationBar: currentPage.value == AppPages.noticesList
        ? BottomNavigationBar(
            onTap: (selected) {
              currentNoticesList.value = selected;
            },
            currentIndex: currentNoticesList.value,
            items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "All notices"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.recent_actors),
                  label: "My notices",
                )
              ])
        : null,
    floatingActionButton: currentPage.value == AppPages.noticesList
        ? FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("/add-notice",
                  arguments: AddNoticeArguments(onRefresh: onRefresh.value!));
            },
          )
        : null,
  );
}
