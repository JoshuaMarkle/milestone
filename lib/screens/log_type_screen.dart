import 'package:Milestone/widgets/log_editor_widget.dart';
import 'package:flutter/material.dart';

import 'package:Milestone/screens/live_log_screen.dart';
import 'package:Milestone/screens/template_screen.dart';

import '../theme.dart';

List<String> dropdownWeather = <String>["Clear", "Raining", "Snowing", "Foggy"];

class LogTypeScreen extends StatefulWidget {

  const LogTypeScreen({Key? key}) : super(key: key);

  @override
  State<LogTypeScreen> createState() => _LogTypeScreenState();
}

class _LogTypeScreenState extends State<LogTypeScreen> {
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

    return Scaffold(
      backgroundColor: transparentTint,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ), /// Touchable Background
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height / 3 + (commonRatio * 0.04) * 3,
              padding: EdgeInsets.all(commonRatio * 0.04),
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  Container(
                    color: lightGray,
                    height: height * 0.005,
                    width: width * 0.2,
                  ), /// Divider
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LiveDriveScreen(),)
                            );
                          },
                          child: Container(
                            color: white,
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
                                            Icons.play_arrow_rounded,
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
                                          child: Text('Live Drive', style: headerTextStyle),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('Actively Track Driving', style: normalTextStyle),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                      )
                  ), /// Live Drive
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                barrierDismissible: true,
                                pageBuilder: (_, __, ___) => const LogEditor(logEditType: "Past"),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const double begin = 0;
                                  const double end = 1;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return FadeTransition(
                                    opacity: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            color: white,
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
                                            Icons.history_rounded,
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
                                          child: Text('Past Drive', style: headerTextStyle),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('Log Previous Drives', style: normalTextStyle),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                      )
                  ), /// Past Drive
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const TemplateHomeScreen()),
                            );
                          },
                          child: Container(
                            color: white,
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
                                            Icons.present_to_all_rounded,
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
                                          child: Text('Preset Drive', style: headerTextStyle),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('Select Driving Templates', style: normalTextStyle),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                      )
                  ), /// Preset Drive
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

