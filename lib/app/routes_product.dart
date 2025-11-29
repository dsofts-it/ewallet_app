import 'package:ewallet_app/screens/product/app/app_list_screen.dart';
import 'package:ewallet_app/screens/product/app/app_purchase.dart';
import 'package:ewallet_app/screens/product/education/education_list_screen.dart';
import 'package:ewallet_app/screens/product/education/education_purchase.dart';
import 'package:ewallet_app/screens/product/electricity/electricity_purchase.dart';
import 'package:ewallet_app/screens/product/entertainment/entertainment_list_screen.dart';
import 'package:ewallet_app/screens/product/entertainment/entertainment_purchase.dart';
import 'package:ewallet_app/screens/product/game/game_list_screen.dart';
import 'package:ewallet_app/screens/product/game/game_purchase.dart';
import 'package:ewallet_app/screens/product/insurance/insurance_billing.dart';
import 'package:ewallet_app/screens/product/insurance/insurance_list_screen.dart';
import 'package:ewallet_app/screens/product/internet/internet_billing.dart';
import 'package:ewallet_app/screens/product/internet/internet_list_screen.dart';
import 'package:ewallet_app/screens/product/mobile/mobile_list_screen.dart';
import 'package:ewallet_app/screens/product/mobile/mobile_purchase.dart';
import 'package:ewallet_app/screens/product/package_detail_screen.dart';
import 'package:ewallet_app/screens/product/product_detail_screen.dart';
import 'package:ewallet_app/screens/product/tv/tv_billing.dart';
import 'package:ewallet_app/screens/product/tv/tv_list_screen.dart';
import 'package:ewallet_app/screens/search/search_product.dart';
import 'package:ewallet_app/ui/layouts/default_layout.dart';
import 'package:ewallet_app/ui/layouts/general_layout.dart';
import 'package:ewallet_app/widgets/action_header/like_btn.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/app/app_link.dart';

final List<GetPage> routesProduct = [
  GetPage(
    name: AppLink.packageDetail,
    page: () => const DefaultLayout(title: 'Package Detail', content: PackageDetailScreen(), actions: [LikeBtn()]),
  ),
  GetPage(
    name: AppLink.productDetail,
    page: () => const DefaultLayout(title: 'Product Detail', content: ProductDetailScreen(), actions: [LikeBtn()]),
  ),
  GetPage(
    name: AppLink.searchProduct,
    page: () => const GeneralLayout(content: SearchProduct()),
  ),
  GetPage(
    name: AppLink.gameList,
    page: () => const GeneralLayout(content: GameListScreen()),
  ),
  GetPage(
    name: AppLink.gamePurchase,
    page: () => const GeneralLayout(content: GamePurchase()),
  ),
  GetPage(
    name: AppLink.mobileList,
    page: () => const GeneralLayout(content: MobileListScreen()),
  ),
  GetPage(
    name: AppLink.mobilePurchase,
    page: () => const GeneralLayout(content: MobilePurchase()),
  ),
  GetPage(
    name: AppLink.appList,
    page: () => const GeneralLayout(content: AppListScreen()),
  ),
  GetPage(
    name: AppLink.appPurchase,
    page: () => const GeneralLayout(content: AppPurchase()),
  ),
  GetPage(
    name: AppLink.internetList,
    page: () => const GeneralLayout(content: InternetListScreen()),
  ),
  GetPage(
    name: AppLink.internetBilling,
    page: () => const GeneralLayout(content: InternetBilling()),
  ),
  GetPage(
    name: AppLink.tvList,
    page: () => const GeneralLayout(content: TvListScreen()),
  ),
  GetPage(
    name: AppLink.tvBilling,
    page: () => const GeneralLayout(content: TvBilling()),
  ),
  GetPage(
    name: AppLink.insuranceList,
    page: () => const GeneralLayout(content: InsuranceListScreen()),
  ),
  GetPage(
    name: AppLink.insuranceBilling,
    page: () => const GeneralLayout(content: InsuranceBilling()),
  ),
  GetPage(
    name: AppLink.electricityPurchase,
    page: () => const GeneralLayout(content: ElectricityPurchase()),
  ),
  GetPage(
    name: AppLink.entertainmentList,
    page: () => const GeneralLayout(content: EntertainmentListScreen()),
  ),
  GetPage(
    name: AppLink.entertainmentPurchase,
    page: () => const GeneralLayout(content: EntertainmentPurchase()),
  ),
  GetPage(
    name: AppLink.educationList,
    page: () => const GeneralLayout(content: EducationListScreen()),
  ),
  GetPage(
    name: AppLink.educationPurchase,
    page: () => const GeneralLayout(content: EducationPurchase()),
  ),
];