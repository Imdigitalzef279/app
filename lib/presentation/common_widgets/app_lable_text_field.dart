import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class CustomLabelTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? defaultValue;
  final Color? backgroundColor;
  final Color? colorBorder;
  final double? radius;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmit;
  final int? maxLine;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool isRequired;
  final bool enable;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyleLabel;
  final TextStyle? textStyleError;
  final TextStyle? textStyleHint;
  final TextStyle? textStyleInput;
  final String? errorMessage;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const CustomLabelTextField(
      {super.key,
      this.label,
      this.defaultValue = "",
      this.backgroundColor,
      this.colorBorder,
      this.radius,
      this.hintText,
      this.onChanged,
      this.onSubmit,
      this.maxLength,
      this.maxLine,
      this.keyboardType,
      this.isRequired = false,
      this.enable = true,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.textStyleLabel,
      this.textStyleError,
      this.textStyleHint,
      this.textStyleInput,
      this.errorMessage,
      this.inputFormatters,
      this.focusNode,
      this.contentPadding});

  @override
  State<CustomLabelTextField> createState() => _CustomLabelTextFieldState();
}

class _CustomLabelTextFieldState extends State<CustomLabelTextField> {
  late TextEditingController _controller;
  late double _radius;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultValue);
    _radius = widget.radius ?? 8.r;

    _controller.addListener(() {
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void didUpdateWidget(covariant CustomLabelTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.text = widget.defaultValue ?? '';
  }

  Color handleColor() {
    return widget.errorMessage?.isNotEmpty == true
        ? Colors.red
        : AppColors.grey73;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label ?? "",
              style: widget.textStyleLabel,
            ),
            SizedBox(height: 8.h),
          ],
          TextFormField(
            onFieldSubmitted: (value) {
              widget.onSubmit?.call(_controller.text);
            },
            focusNode: widget.focusNode,
            textAlignVertical: TextAlignVertical.center,
            controller: _controller,
            maxLength: widget.maxLength,
            obscuringCharacter: "•",
            maxLines: widget.obscureText ? 1 : widget.maxLine,
            enabled: widget.enable,
            obscureText: widget.obscureText,
            enableSuggestions: true,
            autocorrect: false,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.backgroundColor ?? Colors.transparent,
              // counter: const Offstage(),
              counterText: "",
              contentPadding: widget.contentPadding ??
                  EdgeInsets.only(
                      left: (widget.prefixIcon != null ? 40.w : 15.w),
                      right: (widget.suffixIcon != null ? 40.w : 15.w),
                      top: 15.h,
                      bottom: 15.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_radius),
                borderSide: BorderSide(
                  color: widget.colorBorder ?? handleColor(),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.greyEF),
                  borderRadius: BorderRadius.circular(_radius)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: widget.colorBorder ?? AppColors.grey),
                  borderRadius: BorderRadius.circular(_radius)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.errorMessage?.isNotEmpty != false
                          ? AppColors.grey73
                          : Colors.red),
                  borderRadius: BorderRadius.circular(_radius)),
              hintText: widget.hintText,

              hintStyle: widget.textStyleHint ??
                  TextStyle(
                    fontFamily: 'BeVietNamPro',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 10.w),
                      child: widget.suffixIcon)
                  : null,
              suffixIconConstraints: BoxConstraints(maxWidth: 38.w),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 8.w),
                      child: widget.prefixIcon)
                  : null,
              prefixIconConstraints: BoxConstraints(maxWidth: 38.w),
              isDense: true,
            ),
            keyboardType: widget.keyboardType,
            style: widget.textStyleInput ??
                AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w400, color: AppColors.grey52),
          ),
          if (widget.errorMessage?.isNotEmpty == true)
            Text(
              widget.errorMessage!,
              style: widget.textStyleError ??
                  AppTextStyle.textXs
                      .copyWith(fontWeight: FontWeight.w400, color: Colors.red),
            )
        ],
      ),
    );
  }
}
