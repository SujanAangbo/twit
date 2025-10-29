import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/app/routes/app_route.gr.dart';
import 'package:twit/core/common/form_validation.dart';
import 'package:twit/features/auth/presentation/pages/widgets/auth_button.dart';
import 'package:twit/features/auth/presentation/providers/login_provider.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/focus_scaffold.dart';
import 'package:twit/utils/ui/sized_box.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final provider = ref.read(loginProvider.notifier);
    final state = ref.read(loginProvider);

    return FocusScaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: provider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: provider.emailController,
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: FormValidation.validateEmail,
              ),
              16.heightBox,
              TextFormField(
                controller: provider.passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
                validator: FormValidation.validatePassword,
              ),
              16.heightBox,
              Align(
                child: AuthButton(
                  title: 'Login',
                  isLoading: ref.watch(loginProvider).isLoading,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    provider.login(context, ref);
                  },
                ),
                alignment: Alignment.centerRight,
              ),
              32.heightBox,
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: ColorPalette.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.router.push(SignupRoute());
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
