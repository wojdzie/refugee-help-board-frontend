import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refugee_help_board_frontend/schemas/user/user_schema.dart';
import 'package:refugee_help_board_frontend/services/user_service.dart';
import 'package:refugee_help_board_frontend/stores/user_store.dart';

part 'profile_view.g.dart';

@hcwidget
Widget profileView(BuildContext ctx, WidgetRef ref) {
  final key = useMemoized(() => GlobalKey<FormState>());
  final user = ref.watch(userProvider);
  final userApi = ref.watch(userApiProvider.notifier);

  final loginController = useTextEditingController(text: user?.login ?? "");
  final passwordController =
      useTextEditingController(text: user?.password ?? "");
  final emailController = useTextEditingController(text: user?.email ?? "");

  final isLoading = useState(false);

  return Form(
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
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
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
                        ScaffoldMessenger.of(ctx).showSnackBar(
                          const SnackBar(content: Text('Please wait...')),
                        );

                        isLoading.value = true;

                        final user = User(
                            login: loginController.text,
                            password: passwordController.text,
                            email: emailController.text);

                        final result = await ref
                            .read(userApiProvider.notifier)
                            .modify(user);

                        ScaffoldMessenger.of(ctx).hideCurrentSnackBar();

                        isLoading.value = false;

                        if (result.isSuccess) {
                          Navigator.of(ctx)
                              .pushNamedAndRemoveUntil("/app", (_) => false);
                        } else {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(content: Text(result.error.toString())),
                          );
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
      ));
}
