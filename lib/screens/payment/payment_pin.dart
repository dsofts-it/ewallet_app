import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/widgets/payment/animation_process.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/widgets/auth/pin_verification.dart';
import 'package:get/route_manager.dart';

class PaymentPin extends StatefulWidget {
  const PaymentPin({super.key});

  @override
  State<PaymentPin> createState() => _PaymentPinState();
}

class _PaymentPinState extends State<PaymentPin> {
  bool _isComplete = false;

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Invalid PIN Number!'),
      action: SnackBarAction(
        label: 'CLOSE',
        backgroundColor: colorScheme(context).surfaceContainer,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    return Stack(alignment: Alignment.center, children: [
      /// PIN INPUT
      PINVerification.withGradientBackground(
        secured: true,
        subTitle: 'Please enter the your security PIN (Default: 123456)',
        validateOtp: (String val) async {
          if (val == '123456') {
            return true;
          }
          return false;
        },
        onValidateSuccess: () {
          setState(() {
            _isComplete = true;
          });
          Future.delayed(const Duration(seconds: 3), () {
            Get.toNamed(AppLink.paymentStatus);
          });
        },
        onInvalid: () {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      ),

      /// PAYMENT DONE ANIMATION
      _isComplete ? AnimationProcess() : SizedBox.shrink()
    ]);
  }
}