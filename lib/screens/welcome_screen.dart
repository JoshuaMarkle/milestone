import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Milestone/screens/set_goals_screen.dart';

import '../theme.dart';

class WelcomeInitializer extends StatelessWidget {
  const WelcomeInitializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}


class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final pageController = PageController();

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
        child: PageView(
          controller: pageController,
          children: [
            Container(
              margin: EdgeInsets.all(commonRatio * 0.04),
              child: AnimationLimiter(
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      AnimationConfiguration.staggeredList(
                        position: 1,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: SizedBox(
                                height: height * 0.5,
                                child: Icon(
                                    Icons.celebration_rounded,
                                    color: black,
                                    size: height * 0.25
                                ),
                            ),
                          ),
                        ),
                      ), /// Icon
                      AnimationConfiguration.staggeredList(
                        position: 2,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              'Welcome',
                              textAlign:
                              TextAlign.center,
                              style: titleTextStyle,
                            ),
                          ),
                        ),
                      ), /// Title
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 3,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              'Milestone is a app that aids in tracking driving hours. Our goal is to asist aspiring drivers to track their hours!',
                              textAlign: TextAlign.center,
                              style: normalTextStyle,
                            ),
                          ),
                        ),
                      ), /// Description
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 4,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle, color: accent, size: commonRatio * 0.015,),
                                SizedBox(width: commonRatio * 0.04,),
                                Icon(Icons.circle, color: lightGray, size: commonRatio * 0.015,),
                                SizedBox(width: commonRatio * 0.04,),
                                Icon(Icons.circle, color: lightGray, size: commonRatio * 0.015,),
                              ],
                            ),
                          ),
                        ),
                      ), /// Page Indicator
                      SizedBox(height: height * 0.38 - commonRatio * 0.04 * 5,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 5,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: accent, textStyle: buttonTextStyle),
                                onPressed: () {
                                  pageController.animateToPage(1, duration: const Duration(milliseconds: 2000), curve: Curves.fastLinearToSlowEaseIn);
                                },
                                child: Container(
                                  width: width - commonRatio * 0.04 * 2,
                                  height: commonRatio * 0.04 * 2,
                                  alignment: Alignment.center,
                                  child: Text("Next", style: buttonTextStyle,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ), /// Button
                    ],
                  )
              ),
            ), /// Welcome Page
            Container(
              margin: EdgeInsets.all(commonRatio * 0.04),
              child: AnimationLimiter(
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      AnimationConfiguration.staggeredList(
                        position: 1,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: SizedBox(
                              height: height * 0.5,
                              child: Icon(
                                  Icons.create_rounded,
                                  color: black,
                                  size: height * 0.25
                              ),
                            ),
                          ),
                        ),
                      ), /// Icon
                      AnimationConfiguration.staggeredList(
                        position: 2,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              'Create',
                              textAlign:
                              TextAlign.center,
                              style: titleTextStyle,
                            ),
                          ),
                        ),
                      ), /// Title
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 3,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              'Effortlessly track driving statistics and review history! Create logs to start tracking.',
                              textAlign: TextAlign.center,
                              style: normalTextStyle,
                            ),
                          ),
                        ),
                      ), /// Description
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 4,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle, color: accent, size: commonRatio * 0.015,),
                                SizedBox(width: commonRatio * 0.04,),
                                Icon(Icons.circle, color: accent, size: commonRatio * 0.015,),
                                SizedBox(width: commonRatio * 0.04,),
                                Icon(Icons.circle, color: lightGray, size: commonRatio * 0.015,),
                              ],
                            ),
                          ),
                        ),
                      ), /// Page Indicator
                      SizedBox(height: height * 0.38 - commonRatio * 0.04 * 5,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 5,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: accent, textStyle: buttonTextStyle),
                                onPressed: () {
                                  pageController.animateToPage(2, duration: const Duration(milliseconds: 2000), curve: Curves.fastLinearToSlowEaseIn);
                                },
                                child: Container(
                                  width: width - commonRatio * 0.04 * 2,
                                  height: commonRatio * 0.04 * 2,
                                  alignment: Alignment.center,
                                  child: Text("Next", style: buttonTextStyle,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ), /// Button
                    ],
                  )
              ),
            ), /// Create Page
            Container(
              margin: EdgeInsets.all(commonRatio * 0.04),
              child: AnimationLimiter(
                  child: ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      AnimationConfiguration.staggeredList(
                        position: 1,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: SizedBox(
                              height: height * 0.5,
                              child: Icon(
                                  Icons.explore_rounded,
                                  color: black,
                                  size: height * 0.25
                              ),
                            ),
                          ),
                        ),
                      ), /// Icon
                      AnimationConfiguration.staggeredList(
                        position: 2,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              'Explore',
                              textAlign:
                              TextAlign.center,
                              style: titleTextStyle,
                            ),
                          ),
                        ),
                      ), /// Title
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 3,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              'Get started by setting goals then take a tour through what Milestone can do for you!',
                              textAlign: TextAlign.center,
                              style: normalTextStyle,
                            ),
                          ),
                        ),
                      ), /// Description
                      SizedBox(height: commonRatio * 0.04,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 4,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle, color: accent, size: commonRatio * 0.015,),
                                SizedBox(width: commonRatio * 0.04,),
                                Icon(Icons.circle, color: accent, size: commonRatio * 0.015,),
                                SizedBox(width: commonRatio * 0.04,),
                                Icon(Icons.circle, color: accent, size: commonRatio * 0.015,),
                              ],
                            ),
                          ),
                        ),
                      ), /// Page Indicator
                      SizedBox(height: height * 0.38 - commonRatio * 0.04 * 5,), /// Spacer
                      AnimationConfiguration.staggeredList(
                        position: 5,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: accent, textStyle: buttonTextStyle),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SetGoalsScreen()),
                                  );
                                },
                                child: Container(
                                  width: width - commonRatio * 0.04 * 2,
                                  height: commonRatio * 0.04 * 2,
                                  alignment: Alignment.center,
                                  child: Text("Let's Go!", style: buttonTextStyle,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ), /// Button
                    ],
                  )
              ),
            ), /// Explore
          ],
        ),
      ),
    );
  }
}