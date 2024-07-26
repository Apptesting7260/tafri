import 'package:flutter/material.dart';
import 'package:plusone/utils/colors.dart';

class CustomExpansionWidget extends StatefulWidget {
  final Widget title;
  final Widget body;

  const CustomExpansionWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  _CustomExpansionWidgetState createState() => _CustomExpansionWidgetState();
}

class _CustomExpansionWidgetState extends State<CustomExpansionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            color:clrGreyLight,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: widget.title),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up :Icons.arrow_drop_down_outlined,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:clrGreyLight,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 13),
            margin: EdgeInsets.only(top: 10),
            child: widget.body,
          ),
      ],
    );
  }
}
