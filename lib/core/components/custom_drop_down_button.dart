import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String? title;
  final String? hintText;
  final Color? borderColor;
  final Color? iconColor;
  final Color? fillColor;
  final Color? hintColor;
  final bool? isRequired;
  final double? radius;
  final T? selectedValue;
  final List<T>? items; // Dynamic list of items
  final ValueChanged<T?>? onChanged; // Callback for selected value

  const CustomDropdown({
    super.key,
    this.title,
    this.hintText,
    this.borderColor,
    this.fillColor,
    this.hintColor,
    this.radius,
    this.iconColor,
    this.items, // Pass dropdown items dynamically
    this.onChanged,
    this.selectedValue,
    this.isRequired = false, // Selected value managed externally
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  /// Local state for the selected value
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize local state with the provided selected value
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title != null
            ? Row(
                children: [
                  Text(
                    widget.title ?? '',
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeSemiSmall(context)),
                  ),
                  widget.isRequired == true
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            '*',
                            style: poppinsRegular.copyWith(
                                color: Colors.red,
                                fontSize: getFontSizeSemiSmall(context)),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : const SizedBox.shrink(),
        widget.title != null ? space8H : const SizedBox.shrink(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: widget.fillColor ?? AppColors.navigationColor,
            border: Border.all(
              color: widget.borderColor ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(widget.radius ?? 4.r),
          ),
          child: DropdownButton<T>(
            padding: padding8.copyWith(top: 0, bottom: 0),
            value: selectedValue, // Use local state here
            isExpanded: true,
            underline: const SizedBox(), // Removes the default underline
            style: poppinsMedium.copyWith(
              color: widget.hintColor ?? AppColors.normalDarkWhite,
              fontWeight: FontWeight.w400,
              fontSize: getFontSizeSmall(context),
            ),
            hint: Text(
              widget.hintText ?? AppStaticString.typeHere,
              style: poppinsMedium.copyWith(
                  color: widget.hintColor ?? AppColors.normalDarkWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: getFontSizeSmall(context)),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: widget.iconColor ?? AppColors.whiteLightColor,
              size: 20.sp,
            ),
            items: (widget.items ?? []).map((e) {
              return DropdownMenuItem<T>(
                value: e,
                child: Text(e.toString(), style: poppinsMedium.copyWith(
                  color: AppColors.whiteLightColor,
                    fontWeight: FontWeight.w400,
                    fontSize: getFontSizeSmall(context))),
              );
            }).toList(),
            onChanged: /* widget.onChanged ??*/
                (value) {
              setState(() {
                selectedValue = value; // Update local state
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value); // Notify parent widget
              }
            },
          ),
        ),
      ],
    );
  }
}
