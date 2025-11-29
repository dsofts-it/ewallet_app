import 'package:ewallet_app/widgets/app_button/back_icon_button.dart';
import 'package:ewallet_app/widgets/header/top_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/settings/admin_contact.dart';
import 'package:ewallet_app/widgets/settings/message_form.dart';

class ContactAdmin extends StatefulWidget {
  const ContactAdmin({super.key});

  @override
  State<ContactAdmin> createState() => _ContactAdminState();
}

class _ContactAdminState extends State<ContactAdmin> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: BackIconButton(
          onTap: () {
            Get.back();
          },
        ),
        title: Text('Get In Touch', style: ThemeText.subtitle),
        centerTitle: true,
        flexibleSpace: TopDecoration(),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: ThemePalette.primaryMain,
          labelColor: ThemePalette.primaryMain,
          tabAlignment: TabAlignment.center,
          unselectedLabelColor: colorScheme(context).onSurfaceVariant,
          isScrollable: true,
          dividerHeight: 0,
          labelPadding: EdgeInsets.symmetric(horizontal: spacingUnit(3)),
          tabs: [
            Tab(child: Text('Message'.toUpperCase(), textAlign: TextAlign.center, style: ThemeText.subtitle2)),
            Tab(child: Text('Contact'.toUpperCase(), textAlign: TextAlign.center, style: ThemeText.subtitle2)),
          ]
        ),
      ),
      body: TabBarView(controller: _tabController, children: const [
        MessageForm(),
        AdminContact()
      ])
    );
  }
}