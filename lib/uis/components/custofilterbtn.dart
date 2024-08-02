import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'custoelevatedbtn.dart';

class CustoFilterBtn extends StatefulWidget {
  final Widget? img;
  final Function() ontap;
  final Widget lable;
  final Color? borderClr;
  final Color backgroundClr;
  const CustoFilterBtn({super.key,this.img,required this.lable,required this.ontap,this.borderClr,required this.backgroundClr});

  @override
  State<CustoFilterBtn> createState() => _CustoFilterBtnState();
}

class _CustoFilterBtnState extends State<CustoFilterBtn> {
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      borderClr: widget.borderClr,
        paddingHz: 10,
        onTap: widget.ontap,
        backgroundClr: widget.backgroundClr,
        child: widget.lable);
  }
}
