import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustoDropDownBtn extends StatefulWidget {
  final List<DropdownMenuItem> itemList;
  final Widget? prefixIcon;
  final Function(dynamic val)? onchange;
  final Color? backClr;
  final Color? borderClr;
  final dynamic val;
  final String? hindtext;
  final Color? hintColor;
  final Widget? suffix;
  final DropdownButtonBuilder? selectedItemBuilder;
  const CustoDropDownBtn({super.key,required this.itemList,this.onchange,this.val,this.prefixIcon,required this.hindtext,this.backClr,this.borderClr, this.hintColor, this.suffix, this.selectedItemBuilder});

  @override
  State<CustoDropDownBtn> createState() => _CustoDropDownBtnState();
}

class _CustoDropDownBtnState extends State<CustoDropDownBtn> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      // alignment: Alignment.center,
      items: widget.itemList??[],
      onChanged:widget.onchange,
      value:widget.val ,
      isExpanded: true,
      // isDense: true,
      hint: Align(
        alignment: Alignment.centerLeft,
        child: Text(widget.hindtext??'',style: TextStyle(
          color: widget.hintColor
        )),
      ),
      icon: const SizedBox.shrink(),
      selectedItemBuilder: widget.selectedItemBuilder,
      decoration: InputDecoration(

        alignLabelWithHint: true,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffix,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: clrGreyTextLight),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 15),
          fillColor:widget.backClr?? clrGreyLight,
          filled: true,
          border:widget.borderClr!=null?OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderClr??clrBlacke),
              borderRadius: BorderRadius.circular(30)) :OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
        focusedBorder:widget.borderClr!=null? OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderClr??clrBlacke),
            borderRadius: BorderRadius.circular(30)):null,
        enabledBorder: widget.borderClr!=null? OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderClr??clrBlacke),
            borderRadius: BorderRadius.circular(30)):null,
      ),

    );
  }
}
