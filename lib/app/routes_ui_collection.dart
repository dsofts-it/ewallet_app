import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/screens/sample_ui/button_collection.dart';
import 'package:ewallet_app/screens/sample_ui/card_collection.dart';
import 'package:ewallet_app/screens/sample_ui/color_collection.dart';
import 'package:ewallet_app/screens/sample_ui/form_input_collection.dart';
import 'package:ewallet_app/screens/sample_ui/shadow_border_radius.dart';
import 'package:ewallet_app/screens/sample_ui/typography_collection.dart';
import 'package:ewallet_app/ui/layouts/default_layout.dart';
import 'package:get/route_manager.dart';

const int pageTransitionDuration = 200;

final List<GetPage> routesUiCollection = [
  GetPage(
    name: AppLink.buttonCollection,
    page: () => const DefaultLayout(title: 'Button Collection', content: ButtonCollection()),
  ),
  GetPage(
    name: AppLink.shadowRoundedCollection,
    page: () => const DefaultLayout(title: 'Shadows and Radius', content: ShadowBorderRadius()),
  ),
  GetPage(
    name: AppLink.typographyCollection,
    page: () => const DefaultLayout(title: 'Typography', content: TypographyCollection()),
  ),
  GetPage(
    name: AppLink.colorCollection,
    page: () => const DefaultLayout(title: 'Color Palette', content: ColorCollection()),
  ),
  GetPage(
    name: AppLink.formSample,
    page: () => const DefaultLayout(title: 'Form Inputs', content: FormInputCollection()),
  ),
  GetPage(
    name: AppLink.cardCollection,
    page: () => const DefaultLayout(title: 'Card Collection', content: CardCollection()),
  ),
];