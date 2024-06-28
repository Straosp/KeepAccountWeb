

import 'package:flutter/material.dart';
import 'package:keep_account_web/utils/screen_utils.dart';

class DynamicLayout extends StatefulWidget{

  final List<Widget> children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final DeviceScreenType screenType;
  const DynamicLayout({super.key, required this.children, required this.screenType ,this.crossAxisAlignment, this.mainAxisAlignment});


  @override
  State<StatefulWidget> createState() => _DynamicLayoutState();

}

class _DynamicLayoutState extends State<DynamicLayout> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenType == DeviceScreenType.large) {
      return Row(
        crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
        children: widget.children,
      );
    }else {
      return Column(
        crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
        children: widget.children,
      );
    }
  }

}