import 'package:ewallet_app/models/list_item.dart';
import 'package:ewallet_app/ui/themes/theme_breakpoints.dart';
import 'package:ewallet_app/utils/picker.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/route_manager.dart';
import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/ui/themes/theme_button.dart';
import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _editProfileKey = GlobalKey<FormState>();
  bool _isNotValid = false;

  String? currency = '(\$)USD - US Dollar';
  final TextEditingController _chooseRef = TextEditingController(text: '(\$)USD - US Dollar');

  List<ListItem> currencyOpt = [
    ListItem(
      value: 'usd',
      label: '(\$)USD',
      text: 'US Dollar',
    ),
    ListItem(
      value: 'rp',
      label: '(Rp)IDR',
      text: 'Indonesian Rupiah',
    ),
    ListItem(
      value: 'yen',
      label: '(¥)YJP',
      text: 'Yen Japan',
    ),
    ListItem(
      value: 'euro',
      label: '(€)EUR',
      text: 'Euro Europe',
    ),
    ListItem(
      value: 'riyal',
      label: '(﷼)SAR',
      text: 'Saudi Arabian Riyal',
    ),
  ];

  void openPicker(BuildContext context) {
    openRadioPicker(
      context: context,
      options: currencyOpt,
      title: 'Choose Currency',
      onSelected: (value) {
        if (value != null) {
          String resultLabel = currencyOpt.firstWhere((e) => e.value == value).label;
          String? resultText = currencyOpt.firstWhere((e) => e.value == value).text;
          _chooseRef.text = '$resultLabel - $resultText';
        }
        setState(() {
          currency = value;
        });
      },
      initialValue: currency,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(spacingUnit(2)),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ThemeSize.sm
            ),
            child: Form(
              key: _editProfileKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    AvatarNetwork(
                      radius: 50,
                      backgroundImage: userAccount.avatar,
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: ThemePalette.secondaryLight,
                      child: Icon(Icons.edit, size: 18, color: ThemePalette.secondaryDark),
                    ),
                  ],
                ),
                const VSpace(),
                AppTextField(
                  label: 'Name',
                  initialValue: userAccount.name,
                  onChanged: (_) {},
                  validator: FormBuilderValidators.required(),
                  errorText: _isNotValid ? 'Please fill your name' : null,
                ),
                const VSpace(),
                AppTextField(
                  label: 'Phone Number',
                  initialValue: '+621234567890',
                  onChanged: (_) {},
                  validator: FormBuilderValidators.phoneNumber(),
                  errorText: _isNotValid ? 'Please fill the correct phone number' : null,
                ),
                const VSpace(),
                AppTextField(
                  label: 'Email',
                  initialValue: 'john.doe@mymail.com',
                  onChanged: (_) {},
                  validator: FormBuilderValidators.email(),
                  errorText: _isNotValid ? 'Please fill the correct email' : null,
                ),
                const VSpace(),
                AppTextField(
                  controller: _chooseRef,
                  label: 'Select Currency',
                  onChanged: (_) {},
                  onTap: () {
                    openPicker(context);
                  },
                  suffix: const Icon(Icons.arrow_drop_down),
                ),
                const VSpace(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      if (_editProfileKey.currentState!.validate()) {
                        Get.toNamed('/profile');
                      } else {
                        setState(() {
                          _isNotValid = true;
                        });
                      }
                    },
                    style: ThemeButton.btnBig.merge(ThemeButton.invert(context)),
                    child: Text('UPDATE'.toUpperCase(), style: ThemeText.subtitle,)
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}