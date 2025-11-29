import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/auth_models.dart';
import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerKey = GlobalKey<FormBuilderState>();
  final AuthService _authService = AuthService();
  bool _loading = false;

  Future<void> _submit() async {
    if (_loading) return;
    if (!(_registerKey.currentState?.saveAndValidate() ?? false)) return;

    final values = _registerKey.currentState?.value ?? {};
    final String name = (values['name'] ?? '').toString().trim();
    final String mobile = (values['mobile'] ?? '').toString().trim();

    setState(() {
      _loading = true;
    });

    try {
      final init = await _authService.signupMobileInit(name: name, mobile: mobile);
      Get.toNamed(
        AppLink.otp,
        arguments: OtpPayload(
          flow: OtpFlow.signup,
          mobile: mobile,
          name: name,
          userId: init.userId,
        ),
      );
    } catch (error) {
      Get.snackbar(
        'Signup failed',
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
        key: _registerKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const VSpace(),
            Text('Register', style: ThemeText.title),
            SizedBox(height: spacingUnit(1)),
            Text(
              'Create a new account with your mobile number to receive an OTP.',
              style: ThemeText.headline.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const VSpace(),
            FormBuilderField(
              name: 'name',
              builder: (FormFieldState<dynamic> field) {
                return AppTextField(
                  label: 'User Name',
                  onChanged: (value) => field.didChange(value),
                  errorText: field.hasError ? 'Please fill your name' : null,
                );
              },
              validator: FormBuilderValidators.required(),
            ),
            const VSpace(),
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
            const VSpaceShort(),
            FormBuilderCheckbox(
              name: 'accept_terms',
              initialValue: false,
              title: const Text('Agree with our terms and conditions'),
              validator: FormBuilderValidators.equal(
                true,
                errorText: 'You must accept terms and conditions to continue',
              ),
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
          ],
        ),
      ),
    );
  }
}
