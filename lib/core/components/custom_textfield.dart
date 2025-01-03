import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {this.inputFormatters,
      this.onFieldSubmitted,
      this.textEditingController,
      this.focusNode,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.cursorColor = AppColors.whiteLightColor,
      this.inputTextStyle,
      this.textAlignVertical = TextAlignVertical.center,
      this.textAlign = TextAlign.start,
      this.onChanged,
      this.maxLines = 1,
      this.validator,
      this.hintText = AppStaticString.typeHere,
      this.hintStyle,
      this.suffixIcon,
      this.suffixIconColor,
      this.isPassword = false,
      this.readOnly = false,
      this.maxLength,
      super.key,
      this.prefixIcon,
      this.onTap,
      this.isCollapsed,
      this.isDense,
      this.border,
      this.focusedBorder,
      this.enabledBorder,
      this.fillColor = AppColors.textFieldColor,
      this.contentPadding = const EdgeInsets.only(left: 10),
      this.title,
      this.isEnable = true,
      this.height, this.isRequired=false});

  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? title;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final FormFieldValidator? validator;
  final String? hintText;
  final TextStyle? hintStyle;

  final Color? suffixIconColor;
  final Color? fillColor;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final OutlineInputBorder? border;

  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? enabledBorder;

  final bool isPassword;
  final bool? isEnable;
  final bool? isRequired;
  final EdgeInsetsGeometry contentPadding;
  final bool readOnly;
  final double? height;
  final int? maxLength;
  final bool? isCollapsed;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap; // Callback function for onTap

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Row(
              children: [
                Text(
                    widget.title ?? '',
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeSemiSmall(context)),
                  ), widget.isRequired==true? Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                       '*',
                      style: poppinsRegular.copyWith(
                        color: Colors.red,
                          fontSize: getFontSizeSemiSmall(context)),
                    ),
                  ):const SizedBox.shrink(),

              ],
            )
            : const SizedBox.shrink(),
        widget.title != null ? space8H : const SizedBox.shrink(),
        SizedBox(
          height: widget.height, // Set the desired height here
          child: TextFormField(
            textAlign: widget.textAlign,
            onTap: widget.onTap,
            enabled: widget.isEnable,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: widget.inputFormatters,
            onFieldSubmitted: widget.onFieldSubmitted,
            readOnly: widget.readOnly,
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            cursorColor: widget.cursorColor,
            style: widget.inputTextStyle ??
                TextStyle(
                    color: AppColors.whiteLightColor,
                    fontWeight: FontWeight.w400,
                    fontSize: getFontSizeSmall(context)),
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            obscureText: widget.isPassword ? obscureText : false,
            validator: widget.validator,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.sp,
                  vertical: widget.maxLines! > 1
                      ? 12.sp
                      : 12.sp), // Adjust vertical padding
              fillColor: widget.fillColor,
              isCollapsed: widget.isCollapsed,
              isDense: widget.isDense,
              errorMaxLines: 2,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                      color: AppColors.normalDarkWhite,
                      fontWeight: FontWeight.w400,
                      fontSize: getFontSizeSmall(context)),
              filled: true,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: toggle,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: obscureText
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                      ),
                    )
                  : widget.suffixIcon,
              suffixIconColor: widget.suffixIconColor,
              border: widget.border,
              focusedBorder: widget.focusedBorder,
              enabledBorder: widget.enabledBorder,
            ),
          ),
        ),
      ],
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
