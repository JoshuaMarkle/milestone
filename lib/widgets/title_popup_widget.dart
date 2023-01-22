import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme.dart';

String titleNotes = "";

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

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
    final noteTextStyle = TextStyle(
      fontSize: height * 0.025,
      fontWeight: FontWeight.w500,
      color: black,
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return const TitlePopupWidget();
        },));
      },
      child: Hero(
        tag: heroNote,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(commonRatio * 0.02),
          decoration: BoxDecoration(
            color: lightGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: titleNotes.isEmpty
                ? Text('Add a title...', style: normalTextStyle,)
                : Text(titleNotes, style: noteTextStyle,),
          ),
        ),
      ),
    );
  }
}



const String heroNote = 'title-hero';

class TitlePopupWidget extends StatefulWidget {
  const TitlePopupWidget({Key? key}) : super(key: key);

  @override
  State<TitlePopupWidget> createState() => TitlePopupWidgetState();
}

class TitlePopupWidgetState extends State<TitlePopupWidget> {

  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteController.text = titleNotes;
  }

  @override
  void dispose() {
    titleNotes = noteController.text;
    super.dispose();
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
    final noteTextStyle = TextStyle(
      fontSize: height * 0.025,
      fontWeight: FontWeight.w500,
      color: black,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SafeArea(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(commonRatio * 0.04),
              child: Hero(
                tag: heroNote,
                child: Container(
                  padding: EdgeInsets.all(commonRatio * 0.04),
                  constraints: BoxConstraints.loose(Size.fromHeight(height * 0.2)),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Text('Title', style: headerTextStyle,),
                        SizedBox(height: commonRatio * 0.04,),
                        Flexible(
                          child: Container(
                            constraints: const BoxConstraints.expand(),
                            decoration: BoxDecoration(
                              color: lightGray,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: noteController,
                              maxLines: 1,
                              style: noteTextStyle,
                              autofocus: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(commonRatio * 0.03),
                                hintText: 'Add a title...',
                                hintStyle: normalTextStyle,
                                border: InputBorder.none,
                              ),
                            ),
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
    );
  }
}




class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}