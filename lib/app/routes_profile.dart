import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/screens/profile/my_favorite_contact.dart';
import 'package:ewallet_app/screens/profile/my_favorite_products.dart';
import 'package:ewallet_app/screens/profile/my_coupons.dart';
import 'package:ewallet_app/screens/profile/setting_pin.dart';
import 'package:ewallet_app/ui/layouts/default_layout.dart';
import 'package:ewallet_app/ui/layouts/general_layout.dart';
import 'package:ewallet_app/screens/profile/detail_point.dart';
import 'package:ewallet_app/screens/profile/edit_password.dart';
import 'package:ewallet_app/screens/profile/edit_profile.dart';
import 'package:ewallet_app/screens/profile/profile_screen.dart';
import 'package:ewallet_app/screens/profile/rewards.dart';
import 'package:ewallet_app/ui/layouts/home_layout.dart';
import 'package:ewallet_app/widgets/action_header/help_icon_btn.dart';
import 'package:get/route_manager.dart';

const int pageTransitionDuration = 200;

final List<GetPage> routesProfile = [
  GetPage(
    name: AppLink.profile,
    page: () => const HomeLayout(content: ProfileScreen()),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: pageTransitionDuration)
  ),
  GetPage(
    name: AppLink.reward,
    page: () => const GeneralLayout(content: Rewards()),
  ),
  GetPage(
    name: AppLink.myVouchers,
    page: () => const DefaultLayout(title: 'My Coupons', content: MyCoupons()),
  ),
  GetPage(
    name: AppLink.favoriteProducts,
    page: () => const DefaultLayout(
      title: 'Favorites',
      content: MyFavoritesProducts(),
      actions: [HelpIconBtn()],
    ),
  ),
  GetPage(
    name: AppLink.favoritesContact,
    page: () => const DefaultLayout(
      title: 'Favorites',
      content: MyFavoritesContact(),
      actions: [HelpIconBtn()],
    ),
  ),
  GetPage(
    name: AppLink.detailPoint,
    page: () => const GeneralLayout(content: DetailPoint()),
  ),
  GetPage(
    name: AppLink.editProfile,
    page: () => const DefaultLayout(title: 'Edit Profile', content: EditProfile()),
  ),
  GetPage(
    name: AppLink.editPassword,
    page: () => const DefaultLayout(title: 'Edit Password', content: EditPassword()),
  ),
  GetPage(
    name: AppLink.settingPin,
    page: () => const DefaultLayout(title: 'PIN Setting', content: SettingPin()),
  ),
];