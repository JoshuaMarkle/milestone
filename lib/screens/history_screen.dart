import 'package:flutter/material.dart';

import '../widgets/generate_pdf.dart';
import '../widgets/history_popup_widget.dart';
import '../theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

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

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                  Text('History', style: headerTextStyle,),
                  IconButton(
                    icon: Icon(
                      Icons.picture_as_pdf_rounded,
                      color: gray,
                    ),
                    onPressed: () {
                      generatePdfFromHiveData(context);
                    },
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints.expand(height: height * 0.85,),
                    child: const HistoryCards(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

