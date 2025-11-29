import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/screens/wallet/history/details/transaction_detail.dart';
import 'package:ewallet_app/screens/wallet/history/details/transfer_detail.dart';
import 'package:ewallet_app/screens/wallet/history/history_screen.dart';
import 'package:ewallet_app/screens/wallet/history/details/purchase_detail.dart';
import 'package:ewallet_app/screens/wallet/history/purchase_history_screen.dart';
import 'package:ewallet_app/screens/wallet/history/wallet_history_screen.dart';
import 'package:ewallet_app/screens/wallet/report_screen.dart';
import 'package:ewallet_app/screens/wallet/request/request_personal.dart';
import 'package:ewallet_app/screens/wallet/request/request_screen.dart';
import 'package:ewallet_app/screens/wallet/request/split_bill.dart';
import 'package:ewallet_app/screens/wallet/request/split_bill_intro.dart';
import 'package:ewallet_app/screens/wallet/scan_qr.dart';
import 'package:ewallet_app/screens/wallet/topup/topup_detail_cc.dart';
import 'package:ewallet_app/screens/wallet/topup/topup_detail_merchant.dart';
import 'package:ewallet_app/screens/wallet/topup/topup_detail_transfer.dart';
import 'package:ewallet_app/screens/wallet/topup/topup_detail_vac.dart';
import 'package:ewallet_app/screens/wallet/topup/topup_history_screen.dart';
import 'package:ewallet_app/screens/wallet/topup/topup_screen.dart';
import 'package:ewallet_app/screens/wallet/topup/topup_status.dart';
import 'package:ewallet_app/screens/wallet/transfer/transfer_bank.dart';
import 'package:ewallet_app/screens/wallet/transfer/transfer_personal.dart';
import 'package:ewallet_app/screens/wallet/transfer/transfer_screen.dart';
import 'package:ewallet_app/screens/wallet/transfer/withdraw_detail.dart';
import 'package:ewallet_app/screens/wallet/transfer/withdraw_screen.dart';
import 'package:ewallet_app/ui/layouts/default_layout.dart';
import 'package:ewallet_app/ui/layouts/general_layout.dart';
import 'package:ewallet_app/widgets/action_header/help_icon_btn.dart';
import 'package:ewallet_app/widgets/action_header/history_btn.dart';
import 'package:get/route_manager.dart';

const int pageTransitionDuration = 200;

final List<GetPage> routesWallet= [
  /// SCAN QR
  GetPage(
    name: AppLink.scanqr,
    page: () => const GeneralLayout(content: ScanQr()),
  ),

  /// TOPUP
  GetPage(
    name: AppLink.topup,
    page: () => DefaultLayout(
      title: 'Topup',
      content: TopupScreen(),
      actions: [HistoryBtn(
        onPressed: () {
          Get.toNamed(AppLink.topupHistory);
        }
      )],
    ),
  ),
  GetPage(
    name: AppLink.topupCc,
    page: () => DefaultLayout(
      title: 'Credit Card',
      content: TopupDetailCC(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.topupVac,
    page: () => DefaultLayout(
      title: 'Virtual Account',
      content: TopupDetailVac(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.topupTransfer,
    page: () => DefaultLayout(
      title: 'Bank Transfer',
      content: TopupDetailTransfer(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.topupMerchant,
    page: () => DefaultLayout(
      title: 'Merchant',
      content: TopupDetailMerchant(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.topupStatus,
    page: () => const GeneralLayout(content: TopupStatus()),
  ),
  GetPage(
    name: AppLink.topupHistory,
    page: () => const GeneralLayout(content: TopupHistoryScreen()),
  ),

  /// TRANSFER
  GetPage(
    name: AppLink.transfer,
    page: () => DefaultLayout(
      title: 'Transfer',
      content: TransferScreen(),
      actions: [HistoryBtn(
        onPressed: () {
          Get.toNamed(AppLink.history);
        }
      )]
    ),
  ),
  GetPage(
    name: AppLink.transferPersonal,
    page: () => DefaultLayout(
      title: 'Personal Transfer',
      content: TransferPersonal(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.transferBank,
    page: () => DefaultLayout(
      title: 'Bank Transfer',
      content: TransferBank(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.withdraw,
    page: () => DefaultLayout(
      title: 'Withdraw',
      content: WithdrawScreen(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.withdrawAtmDetail,
    page: () => DefaultLayout(
      title: 'Withdraw',
      content: WithdrawDetail(target: 'atm'),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.withdrawMerchantDetail,
    page: () => DefaultLayout(
      title: 'Withdraw',
      content: WithdrawDetail(target: 'merchant'),
      actions: [HelpIconBtn()]
    ),
  ),

  /// REQUEST
  GetPage(
    name: AppLink.request,
    page: () => DefaultLayout(
      title: 'Request',
      content: RequestScreen(),
      actions: [HistoryBtn(
        onPressed: () {
          Get.toNamed(AppLink.history);
        }
      )]
    ),
  ),
  GetPage(
    name: AppLink.requestPersonal,
    page: () => DefaultLayout(
      title: 'Request',
      content: RequestPersonal(),
      actions: [HistoryBtn(
        onPressed: () {
          Get.toNamed(AppLink.history);
        }
      )]
    ),
  ),
  GetPage(
    name: AppLink.splitBillIntro,
    page: () => DefaultLayout(
      title: 'Split Bill',
      content: SplitBillIntro(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.splitBill,
    page: () => DefaultLayout(
      title: 'Split Bill',
      content: SplitBill(),
      actions: [HistoryBtn(
        onPressed: () {
          Get.toNamed(AppLink.history);
        }
      )]
    ),
  ),

  /// HISTORY AND REPORT
  GetPage(
    name: AppLink.history,
    page: () => const GeneralLayout(content: HistoryScreen()),
  ),
  GetPage(
    name: AppLink.purchaseHistory,
    page: () => const GeneralLayout(content: PurchaseHistoryScreen()),
  ),
  GetPage(
    name: AppLink.walletHistory,
    page: () => const GeneralLayout(content: WalletHistoryScreen()),
  ),
  GetPage(
    name: AppLink.transactionDetail,
    page: () => const DefaultLayout(
      title: 'Transaction Detail',
      content: TransactionDetail(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.purchaseDetail,
    page: () => const DefaultLayout(
      title: 'Purchased Detail',
      content: PurchaseDetail(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.transferDetail,
    page: () => const DefaultLayout(
      title: 'Transfer Detail',
      content: TransferDetail(),
      actions: [HelpIconBtn()]
    ),
  ),
  GetPage(
    name: AppLink.report,
    page: () => const GeneralLayout(content: ReportScreen()),
  ),
];
