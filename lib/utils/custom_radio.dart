import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final Color activeColor;
  final String text;
  final Color inactiveColor;
  final double splashRadius;
  final double width;

  const CustomRadioButton({super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.activeColor,
    required this.text,
    this.inactiveColor = Colors.black,
    this.splashRadius = 15.0,
    this.width = 1.0
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(splashRadius),
      splashColor: activeColor.withOpacity(0.3),
      child: Container(
        child: Row(
          children: [
            Container(
              width: splashRadius * 1,
              height: splashRadius * 1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? activeColor : inactiveColor,
                  width: width,

                ),
                // color: isSelected ? activeColor : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: splashRadius * .5,
                  height: splashRadius * .5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeColor,
                  ),
                ),
              ) : null,
            ),
            const SizedBox(width: 5,),
            Text(text,style:  const TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }
}
