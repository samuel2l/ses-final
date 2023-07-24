import 'package:flutter/material.dart';

class ItemDivider extends StatelessWidget {
  const ItemDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      // small design lines between the navs
      height: 20,
      thickness: 0,
      indent: 0,
      endIndent: 90,
      color: Color.fromARGB(255, 142, 128, 5),
    );
  }
}
