import 'package:flutter/material.dart';

import '../theme.dart';

class NightHoursWidget extends StatelessWidget {

  final num totalNightLogs;
  final String totalNightTime;
  final double nightProgress;

  const NightHoursWidget({
    Key? key,
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
                    return Transform.rotate(
                      angle: 135 * 3.14 / 180, // 135 degrees in radians
                      child: Icon(
                        Icons.mode_night,
                        color: specialWhite,
                        size: constraints.maxHeight * 0.5,
                      ),
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
                    child: Text('Night Hours', style: headerTextStyle),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$totalNightLogs Logged Drives', style: normalTextStyle),
                      Text(totalNightTime, style: normalTextStyle),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: nightProgress,
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
