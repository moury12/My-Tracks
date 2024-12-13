import 'package:flutter/material.dart';
import 'package:track_trek/view/initial/widgets/custom_bottom_navigation.dart';

class BottomNavigationScreen extends StatelessWidget {
  static const String routeName ='/nav';
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
