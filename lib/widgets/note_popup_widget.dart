import 'package:flutter/material.dart';

import '../theme.dart';

String notes = "";

class NoteWidget extends StatelessWidget {
  const NoteWidget({Key? key}) : super(key: key);

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
          return const NotePopupWidget();
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
            child: notes.isEmpty
                ? Text('Write a note...', style: normalTextStyle,)
                : Text(notes, style: noteTextStyle,),
          ),
        ),
      ),
    );
  }
}



const String heroNote = 'add-todo-hero';

class NotePopupWidget extends StatefulWidget {
  const NotePopupWidget({Key? key}) : super(key: key);

  @override
  State<NotePopupWidget> createState() => _NotePopupWidgetState();
}

class _NotePopupWidgetState extends State<NotePopupWidget> {

  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteController.text = notes;
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
              notes = noteController.text;
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
                  constraints: BoxConstraints.loose(Size.fromHeight(height / 3)),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Text('Notepad', style: headerTextStyle,),
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
                              maxLines: 7,
                              style: noteTextStyle,
                              autofocus: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(commonRatio * 0.03),
                                hintText: 'Write a note...',
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
  Color get barrierColor => transparentTint;

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