import 'package:ewallet_app/constants/app_const.dart';
import 'package:ewallet_app/models/general_list.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';

class SplitBillContacts extends StatelessWidget {
  const SplitBillContacts({
    super.key,
    required this.items,
  });
  
  final List<GeneralList> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(spacingUnit(2)),
      itemCount: items.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final GeneralList item = items[index];
        
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle, size: 16, color: Colors.red)),
            Expanded(
              child: ListTile(
                leading: AvatarNetwork(
                  radius: 20,
                  backgroundImage: item.thumb,
                ),
                title: Text(item.text!, style: ThemeText.paragraph,),
                subtitle: Text(item.desc!, style: ThemeText.caption),
                trailing: Text('${userAccount.currencySymbol}${item.value}', style: ThemeText.paragraphBold),
              ),
            ),
          ],
        );
      },
    );
  }
}