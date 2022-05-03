import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'main.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

@swidget
Widget myApp() => MaterialApp(
    title: "Refugee App",
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const MyHomePage(
      title: "Initial Refugee App",
    ));

final counterProvider = StateProvider((ref) => 0);

@cwidget
Widget myHomePage(BuildContext ctx, WidgetRef ref, {required String title}) {
  var counter = ref.watch(counterProvider);

  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You helped refugees this many times:',
          ),
          Text(
            counter.toString(),
            style: Theme.of(ctx).textTheme.headline4,
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () =>
          ref.read(counterProvider.notifier).update((state) => state + 1),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
  );
}
