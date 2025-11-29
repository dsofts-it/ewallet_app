// ROUTES
import 'package:ewallet_app/app/routes_auth.dart';
import 'package:ewallet_app/app/routes_payment.dart';
import 'package:ewallet_app/app/routes_product.dart';
import 'package:ewallet_app/app/routes_profile.dart';
import 'package:ewallet_app/app/routes_ui_collection.dart';
import 'package:ewallet_app/app/routes_wallet.dart';
import 'package:ewallet_app/screens/help_support/chat_support.dart';
import 'package:ewallet_app/screens/help_support/help_support_screen.dart';
// SCREEN
import 'package:ewallet_app/screens/intro/intro_screen.dart';
import 'package:ewallet_app/screens/intro/start_screen.dart';
import 'package:ewallet_app/screens/messages/notification_screen.dart';
import 'package:ewallet_app/screens/not_found.dart';
import 'package:ewallet_app/screens/help_support/contact.dart';
import 'package:ewallet_app/screens/help_support/faq_list.dart';
import 'package:ewallet_app/screens/profile/terms_condition.dart';
import 'package:ewallet_app/screens/search/search_contact.dart';
import 'package:ewallet_app/screens/search/search_id.dart';
import 'package:ewallet_app/ui/layouts/default_layout.dart';
import 'package:ewallet_app/ui/layouts/general_layout.dart';
import 'package:ewallet_app/ui/layouts/home_layout.dart';
import 'package:ewallet_app/screens/promo/promo_detail.dart';
import 'package:ewallet_app/screens/promo/promo_screen.dart';
import 'package:ewallet_app/screens/promo/voucher_detail.dart';
import 'package:ewallet_app/screens/search/search_not_found.dart';
import 'package:ewallet_app/screens/search/search_list.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/app/app_link.dart';

const int pageTransitionDuration = 200;

final List<GetPage> appRoutes = [
  /// HOME
  GetPage(
    name: AppLink.home,
    page: () => const StartScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: pageTransitionDuration)
  ),
  GetPage(
    name: AppLink.intro,
    page: () => GeneralLayout(content: IntroScreen(saveIntroStatus: () {})),
  ),
  GetPage(
    name: AppLink.notification,
    page: () => HomeLayout(content: NotificationScreen()),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: pageTransitionDuration)
  ),
  GetPage(
    name: AppLink.faq,
    page: () => const GeneralLayout(content: FaqList()),
  ),
  GetPage(
    name: AppLink.helpSupport,
    page: () => const GeneralLayout(content: HelpSupportScreen()),
  ),
  GetPage(
    name: AppLink.chatSupport,
    page: () => const DefaultLayout(title: 'Chat Support', content: ChatSupport()),
  ),
  GetPage(
    name: AppLink.contact,
    page: () => const GeneralLayout(content: ContactAdmin()),
  ),
  GetPage(
    name: AppLink.terms,
    page: () => const DefaultLayout(title: 'Terms and Condition', content: TermsCondition()),
  ),
  GetPage(
    name: AppLink.notFound,
    page: () => const DefaultLayout(title: 'Not Found', content: NotFound()),
  ),

  /// SEARCH
  GetPage(
    name: AppLink.search,
    page: () => const GeneralLayout(content: SearchList()),
  ),
  GetPage(
    name: AppLink.searchId,
    page: () => const GeneralLayout(content: SearchId()),
  ),
  GetPage(
    name: AppLink.searchContact,
    page: () => const GeneralLayout(content: SearchContact()),
  ),
  GetPage(
    name: AppLink.searchNotFound,
    page: () => const DefaultLayout(title: 'Not Found', content: SearchNotFound()),
  ),

  /// PROMO
  GetPage(
    name: AppLink.promo,
    page: () => const HomeLayout(content: PromoScreen()),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: pageTransitionDuration)
  ),
  GetPage(
    name: AppLink.promoDetail,
    page: () => const GeneralLayout(content: PromoDetail()),
  ),
  GetPage(
    name: AppLink.voucherDetail,
    page: () => const GeneralLayout(content: VoucherDetail()),
  ),

  /// PRODUCT
  ...routesProduct,

  /// WALLET
  ...routesWallet,

  /// AUTH
  ...routesAuth,

  /// PROFILE
  ...routesProfile,

  /// PAYMENT
  ...routesPayment,

  /// SAMPLE UI
  ...routesUiCollection,
];