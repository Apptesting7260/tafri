import 'package:flutter/material.dart';
import 'package:plusone/utils/colors.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  final double? height;
  final double? width;
  final double? iHeight;
  final double? iWidth;

  const CustomSwitch({super.key, required this.value, required this.onChanged, this.height, this.width, this.iHeight, this.iWidth});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: widget.width ?? 40,
        height: widget.height ?? 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.value ? clrYellow : Colors.grey.shade400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: widget.iWidth ?? 20,
                height: widget.iHeight ?? 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.value ? Colors.white : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}