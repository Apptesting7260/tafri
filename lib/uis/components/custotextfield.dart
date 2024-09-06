import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class CustoTextFormField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validation;
  final int? maxLength;
  final TextEditingController? controll;
  final Widget? sufixIcon;
  final TextInputType? textKType;
  final double? borderRadius;
  final double? hintSize;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? readonly;
  const CustoTextFormField({super.key,this.hintText,this.sufixIcon,this.controll,this.textKType,this.maxLines,this.maxLength,this.validation, this.onChanged, this.borderRadius, this.hintSize, this.readonly, this.onTap});

  @override
  State<CustoTextFormField> createState() => _CustoTextFormFieldState();
}

class _CustoTextFormFieldState extends State<CustoTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readonly ?? false,
      validator:widget.validation,
      controller: widget.controll,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: widget.textKType??TextInputType.text,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          prefixIcon:widget.sufixIcon==null?null :widget.sufixIcon ,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: widget.hintSize ?? 15,color: clrGreyTextLight),
          contentPadding:  EdgeInsets.symmetric(horizontal: 15,vertical: Get.height*.02),
          fillColor: clrGreyLight,
          filled: true,
          border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(widget.borderRadius ?? 100)),
        // Error border
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 100),
        ),
        // Error border when focused
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 100),
        ),
      ),
    );
  }
}
