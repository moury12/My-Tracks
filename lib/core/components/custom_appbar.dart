import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String? tile;
  const CustomAppbar({
    super.key, this.tile,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Text(tile??''),
    );
  }

  @override

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}