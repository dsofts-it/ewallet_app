import 'dart:convert';

import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/auth_models.dart';
import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/services/storage_service.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  late final OtpPayload payload;
  final AuthService _authService = AuthService();

  bool _loading = false;
  bool _resending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    final args = Get.arguments;
    if (args is OtpPayload) {
      payload = args;
    } else {
      payload = const OtpPayload(flow: OtpFlow.login, mobile: '');
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _persistAuth(AuthVerifyResult result) async {
    final prefs = await SharedPreferences.getInstance();
    await StorageService.saveToken(result.token);
    if (payload.mobile.isNotEmpty) {
      await prefs.setString('authMobile', payload.mobile);
    }
    if (result.user.isNotEmpty) {
      await prefs.setString('authUser', jsonEncode(result.user));
    }
  }

  Future<void> _verify() async {
    if (_loading) return;
    focusNode.unfocus();
    if (!(formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final code = pinController.text.trim();
      AuthVerifyResult result;
      if (payload.flow == OtpFlow.signup) {
        final userId = payload.userId;
        if (userId == null || userId.isEmpty) {
          throw AuthException('Missing userId for signup verification');
        }
        result = await _authService.signupVerify(userId: userId, otp: code);
      } else {
        result = await _authService.loginMobileVerify(mobile: payload.mobile, otp: code);
      }

      await _persistAuth(result);
      if (payload.flow == OtpFlow.signup) {
        Get.offAllNamed(AppLink.pinSetup);
      } else {
        Get.offAllNamed(AppLink.home);
      }
    } catch (error) {
      final message = error.toString();
      setState(() {
        _error = message;
      });
      Get.snackbar(
        'Verification failed',
        message,
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

  Future<void> _resend() async {
    if (_resending) return;
    setState(() {
      _resending = true;
    });
    try {
      if (payload.flow == OtpFlow.signup) {
        await _authService.signupMobileInit(
          name: payload.name,
          mobile: payload.mobile,
        );
      } else {
        await _authService.loginMobileInit(mobile: payload.mobile);
      }
      Get.snackbar(
        'OTP sent',
        'We\'ve resent the code to ${payload.mobile.isNotEmpty ? payload.mobile : 'your phone'}.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        'Failed to resend',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) {
        setState(() {
          _resending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final focusedBorderColor = colorScheme.primary;
    final fillColor = colorScheme.surface;
    final borderColor = colorScheme.outlineVariant;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ThemeSize.xs),
      child: Column(
        children: [
          const VSpace(),
          Text('Check Your Phone', style: ThemeText.title2),
          SizedBox(height: spacingUnit(1)),
          Text(
            payload.mobile.isNotEmpty
                ? 'We\'ve sent the code to ${payload.mobile}'
                : 'We\'ve sent the code to your phone',
            style: ThemeText.headline.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const VSpace(),
          Form(
            key: formKey,
            child: Column(
              children: [
                Pinput(
                  length: 6,
                  controller: pinController,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final code = value?.trim() ?? '';
                    if (code.length != 6) {
                      return 'Enter the 6 digit code';
                    }
                    return null;
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: ThemeText.caption.copyWith(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ],
                const VSpace(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                    onPressed: _verify,
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('VERIFY'),
                  ),
                ),
                const VSpaceShort(),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: ThemeButton.btnBig.merge(ThemeButton.outlinedDefault(context)),
                    onPressed: _resending ? null : _resend,
                    child: _resending
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('SEND AGAIN'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
