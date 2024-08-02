import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final Widget child;
  final double? paddingHz;
  final Color? borderClr;
  final double? paddingVr;
  final Color backgroundClr;
  final Function() onTap;

  const CustomElevatedButton(
      {super.key,
      required this.child,
      required this.onTap,
      required this.backgroundClr,
      this.paddingHz,
      this.paddingVr,
      this.borderClr});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: widget.backgroundClr,
            padding: EdgeInsets.symmetric(
                horizontal: widget.paddingHz ?? 5, vertical: widget.paddingVr ?? 0),
            side: widget.borderClr != null
                ? BorderSide(color: widget.borderClr ?? clrBlacke)
                : BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        child: widget.child);
  }
}
