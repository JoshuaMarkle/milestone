import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data.dart';
import '../theme.dart';



class LiveDriveScreen extends StatefulWidget {
  const LiveDriveScreen({Key? key}) : super(key: key);

  @override
  State<LiveDriveScreen> createState() => _LiveDriveScreenState();
}

class _LiveDriveScreenState extends State<LiveDriveScreen> {

  String _stopwatchText = "0m 00s";
  final _stopWatch = Stopwatch();
  final _timeout = const Duration(seconds: 1);

  void _startTimeout() {
    if (!mounted) {
      return;
    }
    Timer(_timeout, () {
      if (_stopWatch.isRunning) {
        _startTimeout();
      }
      setState(() {
        _setStopwatchText();
      });
    });
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_stopWatch.isRunning) {
        _stopWatch.stop();
      } else {
        _stopWatch.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed() {
    if (_stopWatch.isRunning) {
      _startStopButtonPressed();
    }
    setState(() {
      _stopWatch.reset();
      _setStopwatchText();
    });
  }

  void _setStopwatchText() {
    _stopwatchText = "";
    if (_stopWatch.elapsed.inHours.toString().isNotEmpty) {
      _stopwatchText = '${_stopWatch.elapsed.inHours}h ';
    }
    _stopwatchText = '${_stopWatch.elapsed.inMinutes}m ${(_stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, "0")}s';
  }

  bool isDayFinder() {
    if (DateTime.now().hour >= 18 || DateTime.now().hour <= 6) {
      return false;
    }
    return true;
  }

  Future<void> showResetConfirmationDialog(BuildContext context, VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {

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
        final normalTextStyle = TextStyle(
          fontSize: height * 0.025,
          fontWeight: FontWeight.w500,
          color: gray,
        );
        final alertOptionsTextStyle = TextStyle(
          fontSize: height * 0.025,
          fontWeight: FontWeight.w500,
          color: accent,
        );

        return AlertDialog(
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text('Reset Timer'),
          titleTextStyle: headerTextStyle,
          content: const Text('Are you sure you want to reset the timer?'),
          contentTextStyle: normalTextStyle,
          actions: [
            TextButton(
              child: Container(
                margin: EdgeInsets.all(commonRatio * 0.04),
                child: Text('No', style: alertOptionsTextStyle,),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Container(
                margin: EdgeInsets.all(commonRatio * 0.04),
                child: Text('Yes', style: alertOptionsTextStyle,),
              ),
              onPressed: () {
                _resetButtonPressed();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showPopConfirmationDialog(BuildContext context, VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {

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
        final normalTextStyle = TextStyle(
          fontSize: height * 0.025,
          fontWeight: FontWeight.w500,
          color: gray,
        );
        final alertOptionsTextStyle = TextStyle(
          fontSize: height * 0.025,
          fontWeight: FontWeight.w500,
          color: accent,
        );

        return AlertDialog(
          backgroundColor: white,
          contentPadding: EdgeInsets.all(commonRatio * 0.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Leave Session'),
          titleTextStyle: headerTextStyle,
          content: const Text('Are you sure you want to leave the session?'),
          contentTextStyle: normalTextStyle,
          actions: [
            TextButton(
              child: Container(
                margin: EdgeInsets.all(commonRatio * 0.04),
                child: Text('No', style: alertOptionsTextStyle,),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Container(
                margin: EdgeInsets.all(commonRatio * 0.04),
                child: Text('Yes', style: alertOptionsTextStyle,),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void addLogInfo(DateTime date, int total, String notes, bool isDay, String weather) {
    final newData = LogData()
      ..logDate = date
      ..totalTime = total
      ..notes = notes
      ..isDay = isDay
      ..weather = weather;

    final logBox = Hive.box('LoggedData');
    logBox.add(newData);
    //box.put('mykey', newloginfo);
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
    final headerTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w600,
      color: black,
    );
    final titleTextStyle = TextStyle(
      fontSize: height * 0.1,
      fontWeight: FontWeight.w300,
      color: black,
    );

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(commonRatio * 0.04),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text('Live Session', style: headerTextStyle,),
                  SizedBox(
                    width: commonRatio * 0.04 * 2,
                  )
                ],
              ),
              Expanded(
                  flex: 3,
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_stopwatchText, style: titleTextStyle,),
                          Text(_stopWatch.isRunning ? "Active" : "Paused", style: normalTextStyle,),
                        ],
                      ),
                  ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: commonRatio * 0.04 * 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(commonRatio * 0.01),
                            child: GestureDetector(
                              onTap: () {
                                showPopConfirmationDialog(context, () {});
                              },
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  constraints: const BoxConstraints.expand(),
                                  decoration: BoxDecoration(
                                      color: accent,
                                      shape: BoxShape.circle
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(height * 0.0025),
                                    decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Icon(
                                            Icons.clear_rounded,
                                            color: accent,
                                            size: constraints.maxHeight * 0.5,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: commonRatio * 0.04,),
                          GestureDetector(
                            onTap: _startStopButtonPressed,
                            child: AspectRatio(
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
                                        _stopWatch.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                        color: specialWhite,
                                        size: constraints.maxHeight * 0.5,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: commonRatio * 0.04,),
                          Container(
                            padding: EdgeInsets.all(commonRatio * 0.01),
                            child: GestureDetector(
                              onTap: () {
                                showResetConfirmationDialog(context, () {});
                              },
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  constraints: const BoxConstraints.expand(),
                                  decoration: BoxDecoration(
                                      color: accent,
                                      shape: BoxShape.circle
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(height * 0.0025),
                                    decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Icon(
                                            Icons.undo_rounded,
                                            color: accent,
                                            size: constraints.maxHeight * 0.5,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.06,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent
                        ),
                        onPressed: () {
                          addLogInfo(
                              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                              _stopWatch.elapsed.inMinutes,
                              "No notes taken",
                              isDayFinder(),
                              "Clear"
                          );
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.add, size: commonRatio * 0.04,),
                        label: const Text("Complete drive!"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}