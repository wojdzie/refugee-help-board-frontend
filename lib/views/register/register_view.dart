import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';
import 'package:refugee_help_board_frontend/services/user_service.dart';

part "register_view.g.dart";

@hcwidget
Widget registerView(BuildContext context, WidgetRef ref) {
  final key = useMemoized(() => GlobalKey<FormState>());

  final loginController = useTextEditingController();
  final passwordController = useTextEditingController();
  final emailController = useTextEditingController();

  final isLoading = useState(false);

  return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Center(
          child: Form(
              key: key,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: loginController,
                      decoration: const InputDecoration(
                        labelText: 'Login',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Login can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email (optional)',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: isLoading.value
                            ? null
                            : () async {
                                if (key.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please wait...')),
                                  );

                                  isLoading.value = true;

                                  final user = User(
                                      login: loginController.text,
                                      password: passwordController.text,
                                      email: emailController.text);

                                  final result = await ref
                                      .read(userApiProvider.notifier)
                                      .register(user);

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();

                                  isLoading.value = false;

                                  if (result.isSuccess) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            "/app", (_) => false);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(result.error.toString())),
                                    );
                                  }
                                }
                              },
                        child: isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ))));
}
