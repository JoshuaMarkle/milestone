import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: transparentTint,
    systemNavigationBarColor: white,
    systemNavigationBarDividerColor: lightGray,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.dark) {
      setTheme(true);
    } else {
      setTheme(false);
    }
  });
}
