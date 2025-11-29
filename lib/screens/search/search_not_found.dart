import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: NoData(
        image: ImgApi.nodataSearch,
        title: 'Not Found',
        desc: 'Nulla condimentum pulvinar arcu a pellentesque.',
        primaryAction: () {
          Get.toNamed(AppLink.home);
        },
        primaryTxtBtn: 'BACK TO HOME',
      ),
    );
  }
}