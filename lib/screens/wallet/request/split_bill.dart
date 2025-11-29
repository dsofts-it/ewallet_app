import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/general_list.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/confirm_dialog.dart';
import 'package:ewallet_app/widgets/payment/payment_button.dart';
import 'package:ewallet_app/widgets/wallet/request/request_review.dart';
import 'package:ewallet_app/widgets/wallet/request/split_bill_contacts.dart';
import 'package:ewallet_app/widgets/wallet/request/split_bill_form.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplitBill extends StatelessWidget {
  const SplitBill({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GeneralList> contactBill = [
      GeneralList(value: '20', thumb: ImgApi.avatar[3], desc: 'Lorem ipsum', text: 'Jean Doe'),
      GeneralList(value: '10', thumb: ImgApi.avatar[1], desc: 'Dolor sit amet', text: 'Jena Doe'),
      GeneralList(value: '15', thumb: ImgApi.avatar[6], desc: 'Nam viverra urna in feugiat ultricies', text: 'James Doe'),
    ];
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ThemeSize.sm
        ),
        child: Column(children: [
          SplitBillForm(),
          Expanded(
            child: SplitBillContacts(items: contactBill)
          ),
          PaymentButton(
            actionBtn: 'SEND REQUEST',
            onSubmit: () {
              confirmDialog(
                context,
                title: 'Confirmation',
                content: RequestReview(),
                confirmAction: () {
                  Get.toNamed(AppLink.paymentPin);
                },
                confirmText: 'Send Request'
              );
            },
          ),
          VSpace()
        ]),
      ),
    );
  }
}