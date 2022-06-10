import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:refugee_help_board_frontend/views/landing/components/landing_button.dart';

part "landing_view.g.dart";

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

@swidget
Widget landingView(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue,
    body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 7,
          child: ClipPath(
            clipper: LandingClipper(),
            child: Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                      "Thank you for help",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 64),
                    TextButton(
                      child: Text("See how community is helping",
                          style: Theme.of(context).textTheme.headline6),
                      onPressed: () => Navigator.pushNamed(context, "/report"),
                    ),
                  ])),
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LandingButton(
                  label: "Login",
                  route: "/login",
                  icon: Icons.login,
                ),
                LandingButton(
                    label: "Register",
                    route: "/register",
                    icon: Icons.person_add),
              ],
            ))
      ],
    )));
