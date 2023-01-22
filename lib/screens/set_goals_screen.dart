import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';

import '../navigation_master.dart';
import '../screens/dashboard_screen.dart';
import '../theme.dart';

class SetGoalsScreen extends StatefulWidget {

  final Function(bool)? setBottomNavigationBar;

  const SetGoalsScreen({Key? key, this.setBottomNavigationBar}) : super(key: key);

  @override
  State<SetGoalsScreen> createState() => _SetGoalsScreenState();
}

class _SetGoalsScreenState extends State<SetGoalsScreen> {

  static int dayHours = 50;
  static int nightHours = 10;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.setBottomNavigationBar?.call(false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    /// General Screen Settings
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    final bottomNavHeight = (screenHeight - safeAreaHeight) * 0.075;
    final height = screenHeight - safeAreaHeight - bottomNavHeight;
    final width = MediaQuery.of(context).size.width;
    final commonRatio = (width + height) / 2;

    /// Group of TextStyles
    final normalTextStyle = TextStyle(
      fontSize: height * 0.025,
      fontWeight: FontWeight.w500,
      color: gray,
    );
    final selectedTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w500,
      color: accent,
    );
    final buttonTextStyle = TextStyle(
      fontSize: height * 0.025,
      fontWeight: FontWeight.w500,
      color: specialWhite,
    );
    final headerTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w600,
      color: black,
    );
    final titleTextStyle = TextStyle(
      fontSize: height * 0.05,
      fontWeight: FontWeight.normal,
      color: black,
    );

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(commonRatio * 0.04),
          child: Column(
              children: [
                SizedBox(height: commonRatio * 0.04), /// Spacer
                Text('Setting Goals', style: titleTextStyle,), /// Title
                SizedBox(height: commonRatio * 0.04), /// Spacer
                Text('Day Hours', style: headerTextStyle), /// Day Hours Header
                SizedBox(height: commonRatio * 0.04), /// Spacer
                Expanded(
                  flex: 2,
                  child: NumberPicker(
                    value: dayHours,
                    minValue: 0,
                    maxValue: 60,
                    step: 5,
                    axis: Axis.horizontal,
                    selectedTextStyle: selectedTextStyle,
                    textStyle: normalTextStyle,
                    onChanged: (value) =>
                        setState(() => dayHours = value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: lightGray),
                    ),
                  ),
                ), /// Day Hour Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, size: commonRatio * 0.04, color: gray,),
                      onPressed: () => setState(() {
                        final newValue = dayHours - 5;
                        dayHours = newValue.clamp(0, 60);
                      }),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, size: commonRatio * 0.04, color: gray,),
                      onPressed: () => setState(() {
                        final newValue = dayHours + 5;
                        dayHours = newValue.clamp(0, 60);
                      }),
                    ),
                  ],
                ), /// Plus Minus Day Hours
                SizedBox(height: commonRatio * 0.04 * 2), /// Spacer
                Text('Night Hours', style: headerTextStyle), /// Night Hours Header
                SizedBox(height: commonRatio * 0.04), /// Spacer
                Expanded(
                  flex: 2,
                  child: NumberPicker(
                    value: nightHours,
                    minValue: 0,
                    maxValue: 60,
                    step: 5,
                    axis: Axis.horizontal,
                    selectedTextStyle: selectedTextStyle,
                    textStyle: normalTextStyle,
                    onChanged: (value) =>
                        setState(() => nightHours = value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: lightGray),
                    ),
                  ),
                ), /// Night Hours Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, size: commonRatio * 0.04, color: gray,),
                      onPressed: () => setState(() {
                        final newValue = nightHours - 10;
                        nightHours = newValue.clamp(0, 60);
                      }),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, size: commonRatio * 0.04, color: gray,),
                      onPressed: () => setState(() {
                        final newValue = nightHours + 10;
                        nightHours = newValue.clamp(0, 60);
                      }),
                    ),
                  ],
                ), /// Plus Minus Night Hours
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const DashboardScreen()),
                            );
                          },
                          icon: Icon(Icons.clear, size: commonRatio * 0.04, color: gray,),
                          label: Text("Skip", style: normalTextStyle,),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            var generalData = await Hive.openBox('GeneralData');
                            generalData.put('DayHourGoal', _SetGoalsScreenState.dayHours);
                            generalData.put('NightHourGoal', _SetGoalsScreenState.nightHours);
                            Navigator.pop(context);
                            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
                                .then((value) => runApp(const MasterNavigator()));
                          },
                          icon: Icon(Icons.add, size: commonRatio * 0.04),
                          label: Container(
                            height: commonRatio * 0.04 * 2,
                            alignment: Alignment.center,
                            child: Text("Set Goals", style: buttonTextStyle,)
                          ),
                          style: ElevatedButton.styleFrom(backgroundColor: accent),
                        ),
                      ],
                    ),
                  ),
                ), /// Set Goals & Cancel
              ]
          ),
        ),
      ),
    );
  }
}