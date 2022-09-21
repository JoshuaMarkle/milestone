import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Milestone/navigation_master.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:Milestone/data.dart';
import 'package:Milestone/theme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: transparentTint,
    systemNavigationBarColor: white,
    systemNavigationBarDividerColor: lightGray,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(LogDataAdapter());
  await Hive.openBox('LoggedData');
  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.dark) {
      setTheme(true);
    } else {
      setTheme(false);
    }
  });
}
