import 'package:ewallet_app/app/app_link.dart';
import 'package:ewallet_app/models/faq.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/cards/paper_card.dart';
import 'package:ewallet_app/widgets/decorations/rounded_deco_main.dart';
import 'package:ewallet_app/widgets/faq/chat_support_input.dart';
import 'package:ewallet_app/widgets/faq/support_menu.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:ewallet_app/widgets/profile/news_list.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        /// DEFAULT HEADER
        title: Text('Help and Support', style: ThemeText.subtitle.copyWith(color: colorScheme(context).onSurface)),
        leading: BackIconButton(onTap: () {
          Get.back();
        }),
        centerTitle: true,
        backgroundColor: colorScheme(context).primaryContainer,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: TopDecoration(),
        primary: true,
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SupportMenu()),
          SliverStickyHeader.builder(
            builder: (context, state) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme(context).primaryContainer
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: RoundedDecoMain(
                        height: 80,
                        baseHeight: 20,
                        bgDecoration: BoxDecoration(
                          color: colorScheme(context).surfaceContainerLow
                        ),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacingUnit(2), vertical: spacingUnit(1)),
                      child: ChatSupportInput(),
                    ),
                  ],
                )
              );
            },
            sliver: SliverList(delegate: SliverChildListDelegate([
              VSpaceShort(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spacingUnit(2)),
                child: Text('Most asked questions', style: ThemeText.subtitle),
              ),
              VSpaceShort(),
              ListView.builder(
                padding: EdgeInsets.all(spacingUnit(2)),
                shrinkWrap: true,
                itemCount: 5,
                physics: const ClampingScrollPhysics(),
                itemBuilder: ((BuildContext context, int index) {
                  Faq item = faqData[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: spacingUnit(1)),
                    child: PaperCard(flat: true, content: ListTile(
                      title: Text(item.headerValue, style: ThemeText.subtitle2,),
                      trailing: Icon(Icons.arrow_forward_ios, size: 12, color: colorScheme(context).onPrimaryContainer),
                      onTap: () {
                        Get.toNamed(AppLink.faq);
                      },
                    )),
                  );
                })
              ),
              VSpaceShort(),
              NewsList(),
              VSpaceBig(),
            ])),
          )
        ],
      )
    );
  }
}