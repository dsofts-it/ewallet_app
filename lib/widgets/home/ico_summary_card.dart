import 'package:ewallet_app/models/ico_models.dart';
import 'package:ewallet_app/services/ico_service.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/home/ico_trade_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IcoSummaryCard extends StatefulWidget {
  const IcoSummaryCard({super.key});

  @override
  State<IcoSummaryCard> createState() => _IcoSummaryCardState();
}

class _IcoSummaryCardState extends State<IcoSummaryCard> {
  final IcoService _icoService = IcoService();
  IcoSummary? _summary;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await _icoService.fetchSummary();
      if (!mounted) return;
      setState(() {
        _summary = result;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _openTradeSheet({required bool isBuy}) {
    final summary = _summary;
    final symbol = summary?.tokenSymbol ?? 'ICO';

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => IcoTradeHelper(
        isBuy: isBuy,
        tokenSymbol: symbol,
        onSubmit: (double value) async {
          try {
            final result = isBuy
                ? await _icoService.buyTokens(fiatAmount: value)
                : await _icoService.sellTokens(tokenAmount: value);
            Get.back(); // close sheet
            await handlePaymentResult(
              context: context,
              result: result,
              title: isBuy ? 'Buy $symbol' : 'Sell $symbol',
              onCompleted: _loadSummary,
            );
          } catch (error) {
            Get.snackbar(
              'Transaction failed',
              error.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool wideScreen = ThemeBreakpoints.smUp(context);
    final summary = _summary;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacingUnit(2),
        vertical: spacingUnit(1),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: ThemePalette.gradientMixedLight,
        ),
        child: Padding(
          padding: EdgeInsets.all(spacingUnit(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ICO Wallet', style: ThemeText.subtitle.copyWith(color: Colors.black)),
                  IconButton(
                    onPressed: _loading ? null : _loadSummary,
                    icon: Icon(Icons.refresh, color: Colors.black),
                  ),
                ],
              ),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: LinearProgressIndicator(),
                )
              else if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _error!,
                    style: ThemeText.caption.copyWith(color: Colors.redAccent),
                  ),
                )
              else if (summary != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${summary.tokenSymbol} Balance',
                      style: ThemeText.caption.copyWith(color: Colors.black87),
                    ),
                    SizedBox(height: spacingUnit(1) / 2),
                    Text(
                      summary.balance.toStringAsFixed(2),
                      style: ThemeText.title2.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: spacingUnit(1) / 2),
                    Text(
                      'Value: INR ${summary.valuation.toStringAsFixed(2)}',
                      style: ThemeText.paragraph.copyWith(color: Colors.black87),
                    ),
                    SizedBox(height: spacingUnit(1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoTile('Price', 'INR ${summary.price.toStringAsFixed(2)}'),
                        _infoTile('Token', summary.tokenSymbol),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: spacingUnit(2)),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _loading ? null : () => _openTradeSheet(isBuy: true),
                      style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                      child: Text('Buy', style: ThemeText.subtitle2),
                    ),
                  ),
                  SizedBox(width: spacingUnit(1)),
                  Expanded(
                    child: FilledButton(
                      onPressed: _loading ? null : () => _openTradeSheet(isBuy: false),
                      style: ThemeButton.btnBig.merge(
                        wideScreen ? ThemeButton.tonalSecondary(context) : ThemeButton.outlinedDefault(context),
                      ),
                      child: Text('Sell', style: ThemeText.subtitle2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: spacingUnit(1)),
        padding: EdgeInsets.all(spacingUnit(1)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withValues(alpha: 0.6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: ThemeText.caption.copyWith(color: Colors.black54),
            ),
            SizedBox(height: spacingUnit(1) / 2),
            Text(
              value,
              style: ThemeText.paragraphBold.copyWith(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
