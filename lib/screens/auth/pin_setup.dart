import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/services/storage_service.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/user/auth_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class PinSetup extends StatefulWidget {
  const PinSetup({super.key});

  @override
  State<PinSetup> createState() => _PinSetupState();
}

class _PinSetupState extends State<PinSetup> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;
  final AuthService _authService = AuthService();

  Future<void> _submit() async {
    if (_loading) return;
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;
    final values = _formKey.currentState?.value ?? {};
    final String pin = (values['pin'] ?? '').toString();
    final String confirm = (values['confirm_pin'] ?? '').toString();

    if (pin != confirm) {
      Get.snackbar(
        'PIN mismatch',
        'Both PIN entries must match.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final token = await StorageService.getToken();
      if (token == null || token.isEmpty) {
        throw AuthException('Missing token, please login again.');
      }
      await _authService.setupPin(token: token, pin: pin);
      Get.offAllNamed('/');
    } catch (error) {
      Get.snackbar(
        'PIN setup failed',
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        leading: BackIconButton(
          invert: true,
          onTap: () {
            Get.back();
          },
        ),
      ),
      body: AuthWrap(
        content: FormBuilder(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const VSpace(),
                Text('Set your PIN', style: ThemeText.title),
                SizedBox(height: spacingUnit(1)),
                Text(
                  'Enter a 4 digit PIN for quick login.',
                  style: ThemeText.headline.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const VSpace(),
                FormBuilderTextField(
                  name: 'pin',
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'PIN'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(4),
                    FormBuilderValidators.maxLength(4),
                    FormBuilderValidators.numeric(),
                  ]),
                ),
                const VSpace(),
                FormBuilderTextField(
                  name: 'confirm_pin',
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirm PIN'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(4),
                    FormBuilderValidators.maxLength(4),
                    FormBuilderValidators.numeric(),
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
                        : const Text('SAVE PIN'),
                  ),
                ),
                const VSpaceBig(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
