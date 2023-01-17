import 'package:Milestone/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Milestone/navigation_master.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:Milestone/screens/welcome_screen.dart';
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
  Hive.registerAdapter(GeneralDataAdapter());
  Hive.registerAdapter(LogDataAdapter());
  Hive.registerAdapter(TemplateDataAdapter());
  await Hive.openBox('LoggedData');
  await Hive.openBox('TemplateData');
  var generalData = await Hive.openBox('GeneralData');

  SchedulerBinding.instance.addPostFrameCallback((_) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.dark) {
      generalData.put('isDarkMode', true);
      setTheme(true);
    } else {
      generalData.put('isDarkMode', false);
      setTheme(false);
    }
  });

  if (generalData.isEmpty || generalData.get('FirstOpen', defaultValue: true)) {
    generalData.put('FirstOpen', false);
    generalData.put('DayHourGoal', -1);
    generalData.put('NightHourGoal', -1);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(const WelcomeInitializer()));
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((value) => runApp(const MasterNavigator()));
  }
}
