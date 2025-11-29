import 'package:ewallet_app/constants/img_api.dart';
import 'package:ewallet_app/models/user.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:ewallet_app/utils/no_data.dart';
import 'package:ewallet_app/widgets/user/avatar_network.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
    required this.items,
    required this.keyword,
    this.showAll = false,
    required this.onSelect
  });
  
  final List<User> items;
  final String keyword;
  final bool showAll;
  final Function(User) onSelect;

  @override
  Widget build(BuildContext context) {
    return items.isEmpty ? Center(
      child: NoData(
          image: ImgApi.nodataSearch,
          title: 'No Contact Yet',
          desc: 'Nulla condimentum pulvinar arcu a pellentesque.',
        ),
      ) : ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(spacingUnit(2)),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final User item = items[index];
        final String contact = '${item.name} ${item.phone}';
        
        if (!contact.toLowerCase().contains(keyword.toLowerCase()) && !showAll) {
          return const SizedBox.shrink();
        }
        return ListTile(
          leading: AvatarNetwork(
            radius: 20,
            backgroundImage: item.avatar,
          ),
          title: Text(item.name, style: ThemeText.paragraph,),
          subtitle: Text(item.phone, style: ThemeText.caption),
          onTap: () {
            onSelect(item);
          },
          trailing: item.isFavorited ? Icon(Icons.favorite, size: 18, color: Colors.pink) : null,
        );
      },
    );
  }
}