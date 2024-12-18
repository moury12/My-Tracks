import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class CustomDropdown extends StatefulWidget {
  final String? title;
  final String? hintText;
  final Color? borderColor;
  final Color? iconColor;
  final Color? fillColor;
  final Color? hintColor;
  final double? radius;
  const CustomDropdown({super.key,  this.title, this.hintText, this.borderColor, this.fillColor, this.hintColor, this.radius, this.iconColor});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  ///====================selected value assign to Controller=============================///
  String? selectedValue;

  ///=======================add dynamic list====================///
  final List<String> dropdownItems = [
  "option 1",
  "option 2",
  "option 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [ widget.title != null
          ? Text(
        widget.title ?? '',
        style: poppinsRegular.copyWith(
            fontSize: getFontSizeSemiSmall(context)),
      )
          : const SizedBox.shrink(),
        widget.title != null ? space8H : const SizedBox.shrink(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color:widget.fillColor?? AppColors.navigationColor,
            border: Border.all(color:widget.borderColor?? Colors.transparent,),
            borderRadius: BorderRadius.circular(widget.radius??4.r),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            underline: const SizedBox(), // Removes the default underline
            hint: Text(
              widget.hintText?? AppStaticString.typeHere,
              style: TextStyle(
                  color:widget.hintColor?? AppColors.normalDarkWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: getFontSizeSmall(context)),
            ),
            icon:  Icon(Icons.keyboard_arrow_down, color:widget.iconColor?? AppColors.whiteLightColor),
            items: dropdownItems.map((e) => DropdownMenuItem<String>(
             value: e,
              child: Text(e),
            ),).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
