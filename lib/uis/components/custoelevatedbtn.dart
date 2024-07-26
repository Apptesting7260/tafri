import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustoElevatedBtn extends StatefulWidget {
  final Widget child;
  final double? padhor;
  final Color? borderClr;
  final double? padver;
  final Color backgroundClr;
  final Function() onTap;

  const CustoElevatedBtn(
      {super.key,
      required this.child,
      required this.onTap,
      required this.backgroundClr,
      this.padhor,
      this.padver,
      this.borderClr});

  @override
  State<CustoElevatedBtn> createState() => _CustoElevatedBtnState();
}

class _CustoElevatedBtnState extends State<CustoElevatedBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: widget.backgroundClr,
            padding: EdgeInsets.symmetric(
                horizontal: widget.padhor ?? 5, vertical: widget.padver ?? 0),
            side: widget.borderClr != null
                ? BorderSide(color: widget.borderClr ?? clrBlacke)
                : BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        child: widget.child);
  }
}
