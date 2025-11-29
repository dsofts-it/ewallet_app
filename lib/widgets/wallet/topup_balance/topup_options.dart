import 'package:flutter/material.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/expanded_section.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/bank_list.dart';
import 'package:ewallet_app/widgets/wallet/topup_balance/merchant_list.dart';

class TopupOptions extends StatelessWidget {
  const TopupOptions({super.key, required this.topupMethod, required this.setTopupMethod});

  final String topupMethod;
  final Function(String) setTopupMethod;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(spacingUnit(2)),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Text('Choose Topup Method', style: ThemeText.subtitle2),
        const VSpaceShort(),
        /// CREDIT CARD
        InkWell(
          onTap: () {
            setTopupMethod('credit-card');
          },
          child: PaperCard(
            flat: true,
            colouredBorder: topupMethod == 'credit-card',
            content: ListTile(
              leading: Icon(Icons.credit_card, size: 36, color: colorScheme(context).onSurface),
              title: Text('Credit Card', style: ThemeText.subtitle),
              subtitle: Text('Topup with credit card', style: ThemeText.paragraph),
              trailing: topupMethod == 'credit-card' ?
                Icon(Icons.check_circle, color: ThemePalette.primaryMain)
                : Icon(Icons.circle_outlined, color: colorScheme(context).outline),
            )
          ),
        ),
        SizedBox(height: spacingUnit(2)),

        /// VIRTUAL ACCOUNT
        OptionExpanded(
          title: 'Virtual Account',
          subtitle: 'Choose virtual account bank',
          icon: Icons.contacts,
          isExpanded: topupMethod == 'vac',
          onTap: () {
            setTopupMethod('vac');
          },
          child: const BankList()
        ),
        SizedBox(height: spacingUnit(2)),

        /// TRANSFER BANK
        OptionExpanded(
          title: 'Bank Transfer',
          subtitle: 'Choose bank for topup method',
          icon: Icons.account_balance,
          isExpanded: topupMethod == 'transfer',
          onTap: () {
            setTopupMethod('transfer');
          },
          child: const BankList()
        ),
        SizedBox(height: spacingUnit(2)),

        /// MERCHANT
        OptionExpanded(
          title: 'Merchants',
          subtitle: 'Choose merchants for topup',
          icon: Icons.store,
          isExpanded: topupMethod == 'merchant',
          onTap: () {
            setTopupMethod('merchant');
          },
          child: const MerchantList()
        ),
      ]
    );
  }
}

class OptionExpanded extends StatefulWidget {
  const OptionExpanded({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
    required this.isExpanded,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final bool isExpanded;
  final Function() onTap;

  @override
  State<OptionExpanded> createState() => _OptionExpandedState();
}

class _OptionExpandedState extends State<OptionExpanded> with SingleTickerProviderStateMixin {
  late AnimationController rotateController;
  late Animation<double> animation; 

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runRotateCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100)
    );
    animation = CurvedAnimation(
      parent: rotateController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runRotateCheck() {
    if(widget.isExpanded) {
      rotateController.forward();
    }
    else {
      rotateController.reverse();
    }
  }

  @override
  void didUpdateWidget(OptionExpanded oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runRotateCheck();
  }

  @override
  void dispose() {
    rotateController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: PaperCard(
        flat: true,
        colouredBorder: widget.isExpanded,
        content: Column(
          children: [
            ListTile(
              leading: Icon(widget.icon, size: 36, color: colorScheme(context).onSurface),
              title: Text(widget.title, style: ThemeText.subtitle),
              subtitle: Text(widget.subtitle, style: ThemeText.paragraph),
              trailing: RotationTransition(
                turns: Tween(begin: 0.0, end: 0.25).animate(animation),
                child: Icon(Icons.arrow_forward_ios_outlined, size: 24, color: colorScheme(context).primary)
              ),
            ),
            ExpandedSection(
              expand: widget.isExpanded,
              child: widget.child
            )
          ],
        )
      ),
    );
  }
}