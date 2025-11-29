import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/shimmer_preloader.dart';
import 'package:ewallet_app/controller/input_id_controller.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/decorations/rounded_deco_main.dart';
import 'package:ewallet_app/widgets/product/detail/vendor_detail.dart';
import 'package:ewallet_app/widgets/product/input_id_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductHeaderInput extends StatefulWidget {
  const ProductHeaderInput({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  State<ProductHeaderInput> createState() => _ProductHeaderInputState();
}

class _ProductHeaderInputState extends State<ProductHeaderInput> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    final InputIdController inputController = Get.put(InputIdController());

    return AppBar(
      centerTitle: true,
      forceMaterialTransparency: true,
      titleSpacing: 0,
      actionsPadding: EdgeInsets.symmetric(horizontal: spacingUnit(1)),
      leading: BackIconButton(
        invert: true,
        onTap: () {
          Get.back();
        },
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: Text(widget.title, style: ThemeText.subtitle.copyWith(color: Colors.white)),

      /// BACKGROUND
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.image,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: double.infinity,
                height: 120,
                child: ShimmerPreloader()
              );
            },
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 1),
                    Colors.black.withValues(alpha: 0.75),
                    Colors.black.withValues(alpha: 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
              ),
            ) 
          )
        ]
      ),

      /// ACTION BUTTON
      actions: <Widget>[
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            iconSize: 16,
            onPressed: () {
              setState(() {
                _liked = !_liked;
              });
            },
            style: IconButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: Colors.white
              )
            ),
            icon: Icon(_liked ? Icons.favorite : Icons.favorite_outline, color: _liked ? Colors.pink : Colors.white)
          ),
        ),
        SizedBox(width: spacingUnit(1)),
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            iconSize: 16,
            onPressed: () {
              showVendorDetail(context);
            },
            style: IconButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: Colors.white
              )
            ),
            icon: Icon(Icons.info, color: Colors.white)
          ),
        ),
      ],

      /// FIELD INPUT DECORATION
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1.2,
            child: RoundedDecoMain(
              height: 100,
              baseHeight: 60,
              bgDecoration: BoxDecoration(
                color: colorScheme(context).surfaceContainerLow,
                boxShadow: [BoxShadow(
                  color: colorScheme(context).surfaceContainerLowest,
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 2),
                )],
              ),
            ),
          ),
          Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
            child: InputIdNumber(
              placeholder: 'Enter id number',
              helpText: inputController.infoText.value,
              prefixIcon: Icon(Icons.person, color: Colors.black),
              suffixIcon: Icons.contact_phone_rounded,
              controller: inputController.textEditingController,
              withFilter: false,
              recentNumbers: ['1234567890', '0987654321', '13578024680'],
              onGetNumber: () {
                Get.toNamed(AppLink.searchId);
              },
            ),
          )),
        ])
      )
    );
  }
}