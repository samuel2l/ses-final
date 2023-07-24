import 'package:flutter/material.dart';

class NavItems extends StatelessWidget {
  final String text;
  final String myRoute;
  final Icon myIcon;
  NavItems(
      {super.key,
      required this.text,
      required this.myRoute,
      required this.myIcon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: myIcon,
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(myRoute, (route) => false);
      },
    );
  }
}
