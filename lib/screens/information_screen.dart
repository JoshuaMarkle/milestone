import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:Milestone/screens/markdown_screen.dart';

import '../theme.dart';

List<String> markdownFileNames = [
  "assets/introduction.md",
  "assets/preparing_for_the_written_exam.md",
  "assets/preparing_for_the_driving_exam.md",
  "assets/understanding_the_rules_of_the_road.md",
  "assets/maintain_your_drivers_license.md",
  "assets/conclusion.md",
];

class InformationHubScreen extends StatefulWidget {

  final Function(bool) setBottomNavigationBar;

  const InformationHubScreen({Key? key, required this.setBottomNavigationBar}) : super(key: key);

  @override
  State<InformationHubScreen> createState() => _InformationHubScreenState();
}

class _InformationHubScreenState extends State<InformationHubScreen> {

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
                    Text('Information', style: headerTextStyle,),
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
                      SizedBox(height: commonRatio * 0.02,),
                      AnimationConfiguration.staggeredList(
                        position: 1,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MarkdownScreen(
                                      fileName: markdownFileNames[0],
                                      index: 0,
                                      setBottomNavigationBar: widget.setBottomNavigationBar,
                                    );
                                  }),
                                ).then((_) {
                                  widget.setBottomNavigationBar(true);
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(commonRatio * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: gray),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Introduction', style: headerTextStyle,),
                                    ),
                                    SizedBox(height: commonRatio * 0.02,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Importance of Driver's License\nOverview of the Driver's License Process\nRequirements for Obtaining a Driver's License\nTypes of Driver's Licenses",
                                        style: normalTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: commonRatio * 0.04,),
                      AnimationConfiguration.staggeredList(
                        position: 2,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MarkdownScreen(
                                      fileName: markdownFileNames[1],
                                      index: 1,
                                      setBottomNavigationBar: widget.setBottomNavigationBar,
                                    );
                                  }),
                                ).then((_) {
                                  widget.setBottomNavigationBar(true);
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(commonRatio * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: gray),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Preparing for the Written Exam', style: headerTextStyle,),
                                    ),
                                    SizedBox(height: commonRatio * 0.02,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Study Materials and Resources\nTopics Covered on the Exam\nTips for Preparing for the Exam",
                                        style: normalTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: commonRatio * 0.04,),
                      AnimationConfiguration.staggeredList(
                        position: 3,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MarkdownScreen(
                                      fileName: markdownFileNames[2],
                                      index: 2,
                                      setBottomNavigationBar: widget.setBottomNavigationBar,
                                    );
                                  }),
                                ).then((_) {
                                  widget.setBottomNavigationBar(true);
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(commonRatio * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: gray),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Preparing for the Driving Exam', style: headerTextStyle,),
                                    ),
                                    SizedBox(height: commonRatio * 0.02,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Understanding the Test Requirements\nBasic Vehicle Controls\nDefensive Driving Techniques\nTips for Preparing for the Exam\nSample Driving Test Scenarios",
                                        style: normalTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: commonRatio * 0.04,),
                      AnimationConfiguration.staggeredList(
                        position: 4,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MarkdownScreen(
                                      fileName: markdownFileNames[3],
                                      index: 3,
                                      setBottomNavigationBar: widget.setBottomNavigationBar,
                                    );
                                  }),
                                ).then((_) {
                                  widget.setBottomNavigationBar(true);
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(commonRatio * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: gray),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Understanding the Rules of the Road', style: headerTextStyle,),
                                    ),
                                    SizedBox(height: commonRatio * 0.02,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Traffic Laws and Regulations\nRoad Signs and Markings\nRight-of-Way Rules\nDriving in Different Weather Conditions\nTips for Safe Driving Practices",
                                        style: normalTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: commonRatio * 0.04,),
                      AnimationConfiguration.staggeredList(
                        position: 5,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return MarkdownScreen(
                                      fileName: markdownFileNames[4],
                                      index: 4,
                                      setBottomNavigationBar: widget.setBottomNavigationBar,
                                    );
                                  }),
                                ).then((_) {
                                  widget.setBottomNavigationBar(true);
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(commonRatio * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: gray),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Maintain Your Driving License", style: headerTextStyle,),
                                    ),
                                    SizedBox(height: commonRatio * 0.02,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Renewal Requirements\nPenalties for Violating Traffic Laws\nSuspension and Revocation of Driver's License\nDefensive Driving Courses",
                                        style: normalTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: commonRatio * 0.04,),
                      AnimationConfiguration.staggeredList(
                        position: 6,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(milliseconds: 2500),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MarkdownScreen(
                                        fileName: markdownFileNames[5],
                                        index: 5,
                                        setBottomNavigationBar: widget.setBottomNavigationBar,
                                      );
                                    }),
                                  ).then((_) {
                                    widget.setBottomNavigationBar(true);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(commonRatio * 0.04),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: gray),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Conclusion', style: headerTextStyle,),
                                      ),
                                      SizedBox(height: commonRatio * 0.02,),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Importance of Safe Driving\nSummary of Key Points\nFinal Tips for Obtaining and Maintaining Your Driver's License",
                                          style: normalTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBarNav(),
      // floatingActionButton: const BottomActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}