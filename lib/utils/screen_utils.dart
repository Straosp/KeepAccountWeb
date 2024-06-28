import 'package:flutter/material.dart';

enum DeviceScreenType {
  small,middle,large
}

DeviceScreenType getCurrentScreenType(BoxConstraints constraints){
  if (constraints.maxWidth >= 960) {
    return DeviceScreenType.large;
  }else if (constraints.maxWidth < 960 && constraints.maxWidth >= 600) {
    return DeviceScreenType.middle;
  }else {
    return DeviceScreenType.small;
  }
}




extension WidgetWidth on num {
  double getScaleDownWidth(DeviceScreenType screenType){
    if (screenType == DeviceScreenType.small) {
      return this * 1;
    }else if (screenType == DeviceScreenType.middle){
      return this * 0.5;
    }else {
      return this * 0.2;
    }
  }

  double getScaleUpWidth(DeviceScreenType screenType){
    if (screenType == DeviceScreenType.small) {
      return this * 1;
    }else if (screenType == DeviceScreenType.middle){
      return this * 2;
    }else {
      return this * 5;
    }
  }

}