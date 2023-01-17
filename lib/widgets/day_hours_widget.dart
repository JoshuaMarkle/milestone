import 'package:flutter/material.dart';

import '../theme.dart';

class DayHoursWidget extends StatelessWidget {

  final num totalDayLogs;
  final String totalDayTime;
  final double dayProgress;

  const DayHoursWidget({
    Key? key,
    required this.totalDayLogs,
    required this.totalDayTime,
    required this.dayProgress
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

    return SizedBox(
      height: height / 12,
      width: width - commonRatio * 0.04 * 2,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle
              ),
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Icon(
                      Icons.wb_sunny_rounded,
                      color: specialWhite,
                      size: constraints.maxHeight * 0.5,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: commonRatio * 0.04,),
          Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Day Hours', style: headerTextStyle),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$totalDayLogs Logged Drives', style: normalTextStyle),
                      Text(totalDayTime, style: normalTextStyle),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: dayProgress,
                    minHeight: height * 0.0075,
                    color: accent,
                    backgroundColor: lightGray,
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}