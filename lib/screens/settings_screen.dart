import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:Milestone/screens/set_goals_screen.dart';

import '../theme.dart';

class SettingsScreen extends StatefulWidget {

  final Function(bool) setBottomNavigationBar;
  final Function(bool) toggleTheme;
  final Function changeAccent;

  const SettingsScreen({Key? key,
    required this.toggleTheme,
    required this.changeAccent,
    required this.setBottomNavigationBar
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  late Box generalData;
  bool notificationEnabled = true;
  Color selectedColor = accentColors[accentColors.indexOf(accent)];

  void _changeTheme(bool darkMode) {
    widget.toggleTheme(darkMode);
    setState(() {});
  }

  void _changeAccent(int index) {
    selectedColor = accentColors[index];
    accent = accentColors[index];
    widget.changeAccent();
    setState(() {});
  }

  void _changeNot(bool value) {
    setState((){
      notificationEnabled = value;
    });
  }

  @override
  void initState() {
    super.initState();
    generalData = Hive.box('GeneralData');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.setBottomNavigationBar(true);
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
    final headerTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w600,
      color: black,
    );

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(commonRatio * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: gray,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text('Settings', style: headerTextStyle,),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: gray,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: AnimationLimiter(
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 1,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Text('Notifications', style: headerTextStyle,),
                          ),
                        ),
                      ), /// Notification Header
                      AnimationConfiguration.staggeredList(
                        position: 2,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Notifications', style: normalTextStyle),
                                Switch(value: notificationEnabled, onChanged: (bool value) {_changeNot(value);}, activeColor: accent,),
                              ],
                            ),
                          ),
                        ),
                      ), /// Notification Toggle
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 3,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Text('Theme', style: headerTextStyle),
                          ),
                        ),
                      ), /// Theme Header
                      AnimationConfiguration.staggeredList(
                        position: 4,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Dark Mode', style: normalTextStyle),
                                Switch(
                                  activeColor: accent,
                                  value: generalData.get('isDarkMode'),
                                  onChanged: _changeTheme,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ), /// Dark Mode Toggle
                      AnimationConfiguration.staggeredList(
                        position: 5,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Text('Primary Color', style: normalTextStyle),
                          ),
                        ),
                      ), /// Primary Color Selector
                      AnimationConfiguration.staggeredList(
                        position: 6,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: commonRatio * 0.04 * 2,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: accentColors.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      _changeAccent(index);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: commonRatio * 0.02),
                                      decoration: BoxDecoration(
                                        color: accentColors[index],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: (width - commonRatio * 0.04 * 2 - commonRatio * 0.02 * accentColors.length) / accentColors.length,
                                      child: selectedColor == accentColors[index]
                                          ? Icon(Icons.check, color: specialWhite, size: 18)
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ), /// Primary Color Options
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 8,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Text('Extra', style: headerTextStyle,)
                          ),
                        ),
                      ), /// Extra Header
                      AnimationConfiguration.staggeredList(
                        position: 8,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SetGoalsScreen(
                                    setBottomNavigationBar: widget.setBottomNavigationBar,
                                  )),
                                ).then((_) {
                                  widget.setBottomNavigationBar(true);
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(color: gray),
                              ),
                              child: Text('Configure Goals', style: normalTextStyle,),
                            ),
                          ),
                        ),
                      ), /// Configure Goals Button
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const BottomAppBar(),
      // floatingActionButton: const BottomActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}