import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormBuilderState>();
  bool _hidePassword = true;

  void handleShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: ThemeSize.sm
      ),
      child: FormBuilder(
        key: _loginKey,
        child: ListView(padding: EdgeInsets.zero, children: [
          /// TITLE
          const VSpace(),
          Text('Login', style: ThemeText.title),
          SizedBox(height: spacingUnit(1)),
          Text('✨ Welcome back! Please login to your account.', style: ThemeText.headline.copyWith(color: colorScheme.onSurfaceVariant)),
          const VSpace(),
        
          /// INPUT FIELD
          FormBuilderField(
            name: 'name',
            builder: (FormFieldState<dynamic> field) {
              return AppTextField(
                label: 'Email or Phone Number',
                onChanged: (value) => field.didChange(value),
                errorText: field.hasError ? 'Incorrect email or phone number' : null,
              );
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.or([
                FormBuilderValidators.email(),
                FormBuilderValidators.phoneNumber(),
              ])
            ]),
          ),
          const VSpace(),
          FormBuilderField(
            name: 'password',
            builder: (FormFieldState<dynamic> field) {
              return AppTextField(
                label: 'Password',
                obscureText: _hidePassword,
                onChanged: (value) => field.didChange(value),
                errorText: field.hasError ? 'Please fill your password!' : null,
                suffix: IconButton(
                  onPressed: () {
                    handleShowPassword();
                  },
                  icon: _hidePassword == true ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                ),
              );
            },
            validator: FormBuilderValidators.required(),
          ),
          const VSpace(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: () {
                if (_loginKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(_loginKey.currentState?.value.toString());
                  Get.toNamed(AppLink.home);
                }
              },
              style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
              child: Text('CONTINUE', style: ThemeText.subtitle)
            ),
          ),
          const VSpaceBig(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppLink.resetPassword);
              },
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CircleAvatar(
                  backgroundColor: ThemePalette.secondaryMain,
                  radius: 22,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: colorScheme.surface,
                    child: Icon(Icons.live_help_outlined, size: 32, color: ThemePalette.secondaryMain)
                  ),
                ),
                const SizedBox(height: 4),
                Text('Forgot Password', style: ThemeText.caption)
              ]),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppLink.helpSupport);
              },
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CircleAvatar(
                  backgroundColor: ThemePalette.primaryMain,
                  radius: 22,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: colorScheme.surface,
                    child: Icon(Icons.question_answer_outlined, size: 32, color: ThemePalette.primaryMain)
                  ),
                ),
                const SizedBox(height: 4),
                Text('Help and Support', style: ThemeText.caption)
              ]),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppLink.home);
              },
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CircleAvatar(
                  backgroundColor: ThemePalette.tertiaryMain,
                  radius: 22,
                  child: CircleAvatar(
                    backgroundColor: colorScheme.surface,
                    child: Icon(Icons.group_outlined, size: 32, color: ThemePalette.tertiaryDark)
                  ),
                ),
                const SizedBox(height: 4),
                Text('User Demo', style: ThemeText.caption)
              ]),
            ),
          ],)
        ]),
      ),
    );
  }
}