import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/auth_models.dart';
import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormBuilderState>();
  final AuthService _authService = AuthService();
  bool _loading = false;

  Future<void> _submit() async {
    if (_loading) return;
    if (!(_loginKey.currentState?.saveAndValidate() ?? false)) return;

    final values = _loginKey.currentState?.value ?? {};
    final String mobile = (values['mobile'] ?? '').toString().trim();

    setState(() {
      _loading = true;
    });

    try {
      final init = await _authService.loginMobileInit(mobile: mobile);
      Get.toNamed(
        AppLink.otp,
        arguments: OtpPayload(
          flow: OtpFlow.login,
          mobile: mobile,
          userId: init.userId,
        ),
      );
    } catch (error) {
      Get.snackbar(
        'Login failed',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ThemeSize.sm),
      child: FormBuilder(
        key: _loginKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /// TITLE
            const VSpace(),
            Text('Login', style: ThemeText.title),
            SizedBox(height: spacingUnit(1)),
            Text(
              'Welcome back! Use your mobile number to receive an OTP.',
              style: ThemeText.headline.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const VSpace(),

            /// INPUT FIELD
            FormBuilderField(
              name: 'mobile',
              builder: (FormFieldState<dynamic> field) {
                return AppTextField(
                  label: 'Mobile Number',
                  onChanged: (value) => field.didChange(value),
                  errorText: field.hasError ? 'Enter a valid mobile number' : null,
                  type: TextInputType.phone,
                );
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.minLength(6),
              ]),
            ),
            const VSpace(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _submit,
                style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('CONTINUE', style: ThemeText.subtitle),
              ),
            ),
            const VSpaceBig(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(AppLink.resetPassword);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: ThemePalette.secondaryMain,
                        radius: 22,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: colorScheme.surface,
                          child: Icon(Icons.live_help_outlined, size: 32, color: ThemePalette.secondaryMain),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Forgot Password', style: ThemeText.caption)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppLink.helpSupport);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: ThemePalette.primaryMain,
                        radius: 22,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: colorScheme.surface,
                          child: Icon(Icons.question_answer_outlined, size: 32, color: ThemePalette.primaryMain),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Help and Support', style: ThemeText.caption)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppLink.home);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: ThemePalette.tertiaryMain,
                        radius: 22,
                        child: CircleAvatar(
                          backgroundColor: colorScheme.surface,
                          child: Icon(Icons.group_outlined, size: 32, color: ThemePalette.tertiaryDark),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('User Demo', style: ThemeText.caption)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
