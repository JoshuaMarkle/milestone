import 'package:flutter/material.dart';

import '../theme.dart';
import 'day_hours_widget.dart';
import 'night_hours_widget.dart';

class ProgressWidgetCollection extends StatelessWidget {

  final num totalDayLogs;
  final String totalDayTime;
  final double dayProgress;
  final num totalNightLogs;
  final String totalNightTime;
  final double nightProgress;

  const ProgressWidgetCollection({
    Key? key,
    required this.totalDayLogs,
    required this.totalDayTime,
    required this.dayProgress,
    required this.totalNightLogs,
    required this.totalNightTime,
    required this.nightProgress
  }) : super(key: key);

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

    if (dayProgress != -1 && nightProgress != -1) { /// Both Night and Day
      return Column(
        children: [
          const ProgressHeader(),
          DayHoursWidget(
              totalDayLogs: totalDayLogs,
              totalDayTime: totalDayTime,
              dayProgress: dayProgress
          ),
          SizedBox(height: commonRatio * 0.04,),
          NightHoursWidget(
              totalNightLogs: totalNightLogs,
              totalNightTime: totalNightTime,
              nightProgress: nightProgress
          ),
        ],
      );
    } else if (dayProgress != -1 && nightProgress == -1) { /// Only Day
      return Column(
        children: [
          const ProgressHeader(),
          DayHoursWidget(
              totalDayLogs: totalDayLogs,
              totalDayTime: totalDayTime,
              dayProgress: dayProgress
          ),
        ],
      );
    } else if (dayProgress == -1 && nightProgress != -1) { /// Only Night
      return Column(
        children: [
          const ProgressHeader(),
          NightHoursWidget(
              totalNightLogs: totalNightLogs,
              totalNightTime: totalNightTime,
              nightProgress: nightProgress
          ),
        ],
      );
    } else { /// Nothing Is Rendered
      return Container();
    }
  }
}

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({Key? key}) : super(key: key);

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
    final headerTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w600,
      color: black,
    );

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text('Progress', style: headerTextStyle,),
        ), /// Progress Header
        SizedBox(height: commonRatio * 0.04,), /// Spacer
      ],
    );
  }
}

