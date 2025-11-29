import 'package:ewallet_app/ui/themes/theme_palette.dart';
import 'package:ewallet_app/ui/themes/theme_radius.dart';
import 'package:ewallet_app/ui/themes/theme_text.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    this.autofocus = false,
    this.hintText = 'Search',
    required this.textRef,
    this.onSubmitSearch,
    this.onClearSearch,
  });

  final bool autofocus;
  final String hintText;
  final TextEditingController textRef;
  final Function(String)? onSubmitSearch;
  final Function()? onClearSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus,
      controller: textRef,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitSearch,
      style: ThemeText.paragraph,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme(context).onSurfaceVariant, width: 1),
          borderRadius: ThemeRadius.xbig
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemePalette.primaryMain, width: 1),
          borderRadius: ThemeRadius.xbig
        ),
        disabledBorder: InputBorder.none,
        alignLabelWithHint: true,
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.search, size: 20, color: colorScheme(context).onSurface.withValues(alpha: 0.6),)
        ),
        prefixIconConstraints: BoxConstraints(
          maxWidth: 28
        ),
        suffixIcon: textRef.text.isNotEmpty ? IconButton(
          onPressed: () {
            textRef.clear();
            if (onClearSearch != null) {
              onClearSearch!();
            }
          },
          icon: const Icon(Icons.close, size: 20,)
        ) : null
      ),
    );
  }
}