import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String? tile;
  final List<Widget>? action;
  const CustomAppbar({
    super.key, this.tile, this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title:  Text(tile??''),
      actions: action??[],

    );
  }

  @override

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}