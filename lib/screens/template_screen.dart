import 'package:Milestone/widgets/log_editor_widget.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/template_popup_widget.dart';

class TemplateHomeScreen extends StatelessWidget {
  const TemplateHomeScreen({Key? key}) : super(key: key);

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
    final buttonTextStyle = TextStyle(
      fontSize: height * 0.025,
      fontWeight: FontWeight.w500,
      color: specialWhite,
    );

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: commonRatio * 0.04 * 2,
              margin: EdgeInsets.only(
                top: commonRatio * 0.04,
                left: commonRatio * 0.02,
                right: commonRatio * 0.02,
              ),
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
                  Text('Templates', style: headerTextStyle,),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints.expand(height: height - commonRatio * 0.04 * 4,),
                    child: const TemplateCards(),
                  ),
                ],
              ),
            ),
            Container(
              height: commonRatio * 0.04 * 2,
              padding: EdgeInsets.only(
                right: commonRatio * 0.04,
                left: commonRatio * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_rounded),
                    style: ElevatedButton.styleFrom(backgroundColor: accent, textStyle: buttonTextStyle),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          pageBuilder: (_, __, ___) => const LogEditor(logEditType: "Template", boxIndex: 0,),
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
                    label: Container(
                      height: commonRatio * 0.04 * 2,
                      alignment: Alignment.center,
                      child: Text("Add Template", style: buttonTextStyle,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}