import 'package:ewallet_app/models/ico_models.dart';
import 'package:ewallet_app/screens/payment/payment_session_webview.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef TradeSubmitCallback = Future<void> Function(double amount);

class IcoTradeHelper extends StatefulWidget {
  const IcoTradeHelper({
    super.key,
    required this.isBuy,
    required this.tokenSymbol,
    required this.onSubmit,
  });

  final bool isBuy;
  final String tokenSymbol;
  final TradeSubmitCallback onSubmit;

  @override
  State<IcoTradeHelper> createState() => _IcoTradeHelperState();
}

class _IcoTradeHelperState extends State<IcoTradeHelper> {
  final TextEditingController _controller = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_submitting) return;
    final amountText = _controller.text.trim();
    final amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      setState(() {
        _error = 'Enter a valid amount';
      });
      return;
    }

    setState(() {
      _submitting = true;
      _error = null;
    });

    await widget.onSubmit(amount);

    if (mounted) {
      setState(() {
        _submitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBuy = widget.isBuy;

    return Padding(
      padding: EdgeInsets.only(
        left: spacingUnit(2),
        right: spacingUnit(2),
        bottom: MediaQuery.of(context).viewInsets.bottom + spacingUnit(2),
        top: spacingUnit(2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBuy ? 'Buy ${widget.tokenSymbol}' : 'Sell ${widget.tokenSymbol}',
            style: ThemeText.title,
          ),
          SizedBox(height: spacingUnit(1)),
          Text(
            isBuy
                ? 'Enter fiat amount (INR) to purchase tokens.'
                : 'Enter token amount to sell.',
            style: ThemeText.headline,
          ),
          SizedBox(height: spacingUnit(2)),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: isBuy ? 'Amount (INR)' : 'Token Amount',
              errorText: _error,
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: spacingUnit(2)),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _submitting ? null : _handleSubmit,
              style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
              child: _submitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(isBuy ? 'Buy Now' : 'Sell Now'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> handlePaymentResult({
  required BuildContext context,
  required IcoTradeResult result,
  required String title,
  VoidCallback? onCompleted,
}) async {
  final session = result.paymentSession;
  if (session != null && session.isValid) {
    await Get.to(
      () => PaymentSessionWebView(
        session: session,
        title: '$title Payment',
        onCompleted: onCompleted,
      ),
      transition: Transition.rightToLeft,
    );
    return;
  }

  Get.snackbar(
    title,
    'Transaction ${result.status}. Amount: ${result.tokenAmount.toStringAsFixed(2)} tokens',
    snackPosition: SnackPosition.BOTTOM,
  );
  onCompleted?.call();
}
