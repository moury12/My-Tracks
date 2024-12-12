import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/image_constants.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(tile: 'Sign up',),
      body: SingleChildScrollView(
        child: Center(
          child: Column(

            mainAxisSize: MainAxisSize.max,

            children: [
              space24H,
            Image.asset(loginImgUrl,height: 92.h,),
              space16H,
          ],),
        ),
      ),
    );
  }
}


