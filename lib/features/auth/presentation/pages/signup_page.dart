import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/core/common/date_formatter.dart';
import 'package:twit/core/common/form_validation.dart';
import 'package:twit/features/auth/presentation/pages/widgets/auth_button.dart';
import 'package:twit/features/auth/presentation/providers/signup_provider.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/focus_scaffold.dart';
import 'package:twit/utils/ui/sized_box.dart';

@RoutePage()
class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(final BuildContext context, WidgetRef ref) {
    final provider = ref.read(signUpProvider.notifier);
    final state = ref.watch(signUpProvider);

    return FocusScaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: provider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: provider.nameController,
                decoration: const InputDecoration(hintText: 'Full Name'),
                keyboardType: TextInputType.name,
                validator: FormValidation.nameValidator,
              ),
              16.heightBox,
              InkWell(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final data = await showDialog(
                    context: context,
                    builder: (context) {
                      return DatePickerDialog(
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now(),
                        helpText: "Select Your DOB",
                        initialCalendarMode: DatePickerMode.year,
                        fieldLabelText: "Label",
                        fieldHintText: "hint",
                      );
                    },
                  );

                  if (data != null && data is DateTime) {
                    provider.setDob(data);
                  }
                },
                child: TextFormField(
                  controller: TextEditingController(
                    text: provider.dobController.text.trim().isEmpty
                        ? null
                        : DateFormatter.formatDate(
                            DateTime.parse(
                              provider.dobController.text,
                            ).toLocal(),
                          ),
                  ),
                  decoration: const InputDecoration(hintText: 'Date of Birth'),
                  keyboardType: TextInputType.name,
                  enabled: false,
                  onTap: () {
                    print("clicked");
                  },
                  validator: (value) {
                    return FormValidation.emptyValidator(
                      value,
                      "Date of Birth",
                    );
                  },
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              16.heightBox,
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
                  title: 'Sign Up',
                  isLoading: state.isLoading,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    provider.signUp(context);
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
                          context.router.maybePop();
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
