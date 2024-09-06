import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/colors.dart';

class CustomLocationField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validation;
  final int? maxLength;
  final TextEditingController? controller;
  final Widget? sufixIcon;
  final TextInputType? textKType;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final Future<List<dynamic>> Function(String) suggestionsCallback;
  final void Function(dynamic)? onSelected;

  const CustomLocationField(
      {super.key,
      this.onChanged,
      this.hintText,
      this.maxLines,
      this.validation,
      this.maxLength,
      this.controller,
      this.sufixIcon,
      this.textKType,
      this.keyboardType,
      required this.itemBuilder,
      required this.suggestionsCallback,
      this.onSelected});

  @override
  State<CustomLocationField> createState() => _CustomLocationFieldState();
}

class _CustomLocationFieldState extends State<CustomLocationField> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsCallback: widget.suggestionsCallback,
      hideOnEmpty: widget.controller?.text == "" ? true : false,
      onSelected: widget.onSelected,
      loadingBuilder: (context) {
        return SizedBox(
            width: double.maxFinite,
            height: 50,
            child: CupertinoActivityIndicator(
              radius: 10.0,
              color: clrGrey,
            ));
      },
      controller: widget.controller,
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: controller,
          validator: widget.validation,
          focusNode: focusNode,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              prefixIcon: widget.sufixIcon == null ? null : widget.sufixIcon,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: clrGreyTextLight),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: Get.height * .02),
              fillColor: clrGreyLight,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100)),
            // Error border
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(100),
            ),
            // Error border when focused
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        );
      },
      itemBuilder: widget.itemBuilder,
    );
  }
}
