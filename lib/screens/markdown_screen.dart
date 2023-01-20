import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:Milestone/screens/information_screen.dart';
import 'package:Milestone/theme.dart';

class MarkdownScreen extends StatefulWidget {

  final Function(bool) setBottomNavigationBar;
  final String fileName;
  final int index;

  const MarkdownScreen({Key? key, required this.fileName, required this.index, required this.setBottomNavigationBar}) : super(key: key);

  @override
  State<MarkdownScreen> createState() => _MarkdownScreenState();
}

class _MarkdownScreenState extends State<MarkdownScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.setBottomNavigationBar(false);
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

    final markdownStyleSheet = MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      p: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w500, color: gray,),
      a: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w500, color: accent,),
      h1: TextStyle(fontSize: height * 0.05, fontWeight: FontWeight.w600, color: black,),
      h2: TextStyle(fontSize: height * 0.035, fontWeight: FontWeight.w600, color: black,),
      h3: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w600, color: black,),
      listBullet: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w500, color: gray,),
      checkbox: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w600, color: black,),
      blockquote: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w600, color: black,),
      blockquoteDecoration: BoxDecoration(
        color: lightGray,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      tableHead: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w600, color: black,),
      tableBody: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.w500, color: gray,),
      tableBorder: TableBorder(
        top: BorderSide(color: black, width: commonRatio * 0.0025),
        bottom: BorderSide(color: black, width: commonRatio * 0.0025),
        left: BorderSide(color: black, width: commonRatio * 0.0025),
        right: BorderSide(color: black, width: commonRatio * 0.0025),
        horizontalInside: BorderSide(color: black, width: commonRatio * 0.0025),
        verticalInside: BorderSide(color: black, width: commonRatio * 0.0025),
        borderRadius: BorderRadius.circular(5),
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border.all(width: 2, color: white),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      blockSpacing: commonRatio * 0.02,
    );

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: FutureBuilder(
          future: rootBundle.loadString(markdownFileNames[widget.index]),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
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
                          color: white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child:  Column(
                      children: [
                        Expanded(
                          child: Markdown(
                            data: snapshot.data!,
                            styleSheet: markdownStyleSheet,
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_rounded, size: commonRatio * 0.04, color: gray),
                              label: Text("Go Back", style: normalTextStyle),
                            ),   /// Cancel Button
                            TextButton.icon(
                              onPressed: () {
                                if (widget.fileName == "assets/conclusion.md") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return InformationHubScreen(setBottomNavigationBar: widget.setBottomNavigationBar,);
                                    }),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MarkdownScreen(
                                        fileName: markdownFileNames[widget.index+1],
                                        index: widget.index+1,
                                        setBottomNavigationBar: widget.setBottomNavigationBar,
                                      );
                                    }),
                                  );
                                }
                              },
                              icon: Icon(Icons.arrow_forward_rounded, size: commonRatio * 0.04, color: gray),
                              label: Text("Next Page", style: normalTextStyle),
                            ),   /// Create Button
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
                child: CircularProgressIndicator(
                  color: accent,
                )
            );
          },
        ),
      ),
    );
  }
}
