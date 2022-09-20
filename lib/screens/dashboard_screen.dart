import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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
    final headerTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w600,
      color: black,
    );
    final totalTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w600,
      color: specialWhite,
    );
    final timeTextStyle = TextStyle(
      fontSize: height * 0.05,
      fontWeight: FontWeight.normal,
      color: specialWhite,
    );

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Container(
            height: safeAreaHeight,
            color: accent,
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                          color: accent,
                        ),
                      ), /// Background Color
                      Container(
                        margin: EdgeInsets.all(commonRatio * 0.04),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.menu_rounded, color: specialWhite,),
                                  Icon(Icons.settings_rounded, color: specialWhite,)
                                ],
                              ),
                            ), /// Top Icons
                            Expanded(
                              flex: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total Drive Time', style: totalTextStyle,),
                                  Text(totalTime, style: timeTextStyle,),
                                ],
                              ),
                            ), /// Total Time Label
                            Expanded(
                              flex: 6,
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Tips', style: headerTextStyle,),
                                      Text('A stop sign means stop!', style: normalTextStyle,),
                                    ],
                                  )
                              ),
                            ), /// Tips Box
                          ],
                        ),
                      ),
                    ],
                  ),
                ), /// Top Portion
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(commonRatio * 0.04),
                    child: Column(
                      children: [
                        ProgressWidgetCollection(
                          totalDayLogs: totalDayLogs,
                          totalDayTime: totalDayTime,
                          dayProgress: dayProgress,
                          totalNightLogs: totalNightLogs,
                          totalNightTime: totalNightTime,
                          nightProgress: nightProgress,
                        ),
                      ],
                    ),
                  ),
                ), /// Bottom Portion
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: const BottomAppBarNav(),
      // floatingActionButton: const BottomActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
