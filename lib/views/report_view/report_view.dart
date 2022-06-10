import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/services/report_service.dart';
import 'package:refugee_help_board_frontend/views/landing/components/landing_button.dart';

part "report_view.g.dart";

class LandingClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;

    const difference = 0.1;

    final waveStart = height * (1 - difference * 2);
    final waveControl1 = height * (1 - difference * 1 / 2);
    final waveMiddle = height * (1 - difference);
    final waveControl2 = height * (1 - difference * 3 / 2);
    final waveEnd = height;

    final path = Path();

    path.lineTo(0, waveStart);
    path.quadraticBezierTo(width * 0.2, waveControl1, width * 0.5, waveMiddle);
    path.quadraticBezierTo(width * 0.8, waveControl2, width, waveEnd);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

@hcwidget
Widget reportView(BuildContext context, WidgetRef ref) {
  final overviewData = useState<Map<String, dynamic>?>(null);

  final initialFetch = useCallback(() async {
    final result = await ref.read(reportApiProvider.notifier).fetchOverview();

    if (result.isSuccess) {
      overviewData.value = result.data;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Problem with fetching notices')),
      );
    }
  }, []);

  useEffect(() {
    initialFetch();

    return null;
  }, []);

  if (overviewData.value == null) {
    return const CircularProgressIndicator();
  }

  return Scaffold(
      appBar: AppBar(
        title: const Text("Community statistics"),
      ),
      backgroundColor: Colors.blue,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
            child: ClipPath(
              clipper: LandingClipper(),
              child: Container(
                color: Colors.white,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        "In total:",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 48),
                      Text(
                        "Requests created: ${overviewData.value!['requests']['total']}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        "Requests closed: ${overviewData.value!['requests']['total'] - overviewData.value!['requests']['active']}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 48),
                      Text(
                        "Offers created: ${overviewData.value!['offers']['total']}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        "Offers closed: ${overviewData.value!['offers']['total'] - overviewData.value!['offers']['active']}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 48),
                    ])),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LandingButton(
                      label: "Generate periodic report",
                      route: "/periodic-report",
                      icon: Icons.person_add),
                ],
              ))
        ],
      )));
}
