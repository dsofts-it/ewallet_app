import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/screens/payment/payment_cart.dart';
import 'package:ewallet_app/screens/payment/payment_pin.dart';
import 'package:ewallet_app/screens/payment/payment_screen.dart';
import 'package:ewallet_app/screens/payment/payment_status.dart';
import 'package:ewallet_app/ui/layouts/default_layout.dart';
import 'package:ewallet_app/ui/layouts/general_layout.dart';
import 'package:ewallet_app/widgets/app_button/cart_button.dart';
import 'package:get/route_manager.dart';

const int pageTransitionDuration = 200;

final List<GetPage> routesPayment = [
  GetPage(
    name: AppLink.payment,
    page: () => const DefaultLayout(title: 'Payment', content: PaymentScreen(), actions: [CartButton()],),
  ),
  GetPage(
    name: AppLink.cart,
    page: () => const DefaultLayout(title: 'Payment Cart', content: PaymentCart()),
  ),
  GetPage(
    name: AppLink.paymentPin,
    page: () => const GeneralLayout(content: PaymentPin()),
  ),
  GetPage(
    name: AppLink.paymentStatus,
    page: () => const GeneralLayout(content: PaymentStatus()),
  ),
];