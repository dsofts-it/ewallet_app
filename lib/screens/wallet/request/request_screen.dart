import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/widgets/wallet/request/request_menu.dart';
import 'package:ewallet_app/widgets/wallet/recent_transactions.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ListView(padding: EdgeInsets.all(spacingUnit(1)), shrinkWrap: true, children: [
      RequestMenu(),
      VSpaceBig(),
      RecentTransactions(),
    ]);
  }
}