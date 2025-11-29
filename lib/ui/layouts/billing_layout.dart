import 'package:ewallet_app/widgets/product/header/product_header_input.dart';
import 'package:flutter/material.dart';

class BillingLayout extends StatelessWidget {
  const BillingLayout({
    super.key,
    required this.name,
    required this.image,
    required this.child,
  });

  final String name;
  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: ProductHeaderInput(
          title: name,
          image: image
        )
      ),
      body: child
    );
  }
}