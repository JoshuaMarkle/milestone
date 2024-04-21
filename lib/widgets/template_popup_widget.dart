import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';

import '../data.dart';
import '../theme.dart';
import 'log_editor_widget.dart';


class TemplateCards extends StatelessWidget {
  const TemplateCards({Key? key}) : super(key: key);

  Widget _buildListView() {
    final templateBox = Hive.box('TemplateData');
    return AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: Hive.box('TemplateData').listenable(),
            builder: (context, box, child) => ListView.builder(
              itemCount: templateBox.length,
              itemBuilder: (BuildContext context, int index) {
                final data = templateBox.getAt(index) as TemplateData;
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(milliseconds: 2500),
                      child: TemplateCard(
                        title: data.title,
                        totalTime: data.totalTime,
                        notes: data.notes,
                        isDay: data.isDay,
                        weather: data.weather,
                        boxIndex: index,
                      ),
                    ),
                  ),
                );
              },
            ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }
}


class TemplateCard extends StatefulWidget {
  final String title;
  final int totalTime;
  final String notes;
  final bool isDay;
  final String weather;
  final int boxIndex;

  const TemplateCard(
      {Key? key,
        required this.title,
        required this.totalTime,
        required this.notes,
        required this.isDay,
        required this.weather,
        required this.boxIndex})
      : super(key: key);

  @override
  TemplateCardState createState() => TemplateCardState();
}

class TemplateCardState extends State<TemplateCard> {

  bool notesLines() {
    if (widget.notes.length > 48) {
      return true;
    }
    return false;
  }

  String totalTimeToString() {
    if (widget.totalTime < 60 || widget.totalTime == 0) {
      return "${widget.totalTime}m";
    } else if (widget.totalTime % 60 == 0) {
      return "${(widget.totalTime / 60).floor()}h";
    } else {
      return "${(widget.totalTime / 60).floor()}h ${widget.totalTime % 60}m";
    }
  }

  double getTextHeight(String text) {

    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    final bottomNavHeight = (screenHeight - safeAreaHeight) * 0.075;
    final height = screenHeight - safeAreaHeight - bottomNavHeight;
    final width = MediaQuery.of(context).size.width;
    final commonRatio = (width + height) / 2;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: height * 0.025,
          fontWeight: FontWeight.w500,
          color: gray,
        ),
      ),
      maxLines: null,
      textDirection: ui.TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: MediaQuery.of(context).size.width - commonRatio * 0.04 * 4);

    return textPainter.size.height;
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
    final headerTextStyle = TextStyle(
      fontSize: height * 0.03,
      fontWeight: FontWeight.w600,
      color: black,
    );

    return Hero(
      tag: 'templateCard',
      child: Padding(
        padding: EdgeInsets.only(right: commonRatio * 0.04, left: commonRatio * 0.04),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return TemplateCardPopup(
                title: widget.title,
                totalTime: widget.totalTime,
                notes: widget.notes,
                isDay: widget.isDay,
                weather: widget.weather,
                boxIndex: widget.boxIndex,
              );
            },));
          },
          child: Container(
            constraints: BoxConstraints.expand(height: height * 0.1),
            margin: EdgeInsets.only(bottom: commonRatio * 0.04),
            padding: EdgeInsets.only(right: commonRatio * 0.04, top: commonRatio * 0.04, left: commonRatio * 0.04, bottom: commonRatio * 0.02),
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: boxShadow,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: headerTextStyle
                      ),
                      Text(
                          totalTimeToString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: headerTextStyle
                      ),
                    ],
                  ), /// Date & Total Driven Time
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5,
                    ),
                    color: lightGray,
                    height: height * 0.005,
                    width: width * 0.2,
                  ), /// Divider
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class TemplateCardPopup extends StatefulWidget {
  late String title;
  late int totalTime;
  late String notes;
  late bool isDay;
  late String weather;
  late int boxIndex;

  TemplateCardPopup(
      {Key? key,
        required this.title,
        required this.totalTime,
        required this.notes,
        required this.isDay,
        required this.weather,
        required this.boxIndex})
      : super(key: key);

  @override
  TemplateCardPopupState createState() => TemplateCardPopupState();
}

class TemplateCardPopupState extends State<TemplateCardPopup> {

  void addLogInfo() {
    final newData = LogData()
      ..logDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
      ..totalTime = widget.totalTime
      ..notes = "${widget.title}: ${widget.notes}"
      ..isDay = widget.isDay
      ..weather = widget.weather;

    final logData = Hive.box('LoggedData');
    logData.add(newData);
    Navigator.pop(context);
  }

  void reloadInformation() {
    setState(() {
      final data = Hive.box('TemplateData').getAt(widget.boxIndex);
      widget.title = data.title;
      widget.totalTime = data.totalTime;
      widget.notes = data.notes;
      widget.isDay = data.isDay;
      widget.weather = data.weather;
    });
  }

  bool notesLines() {
    if (widget.notes.length > 48) {
      return true;
    }
    return false;
  }

  String totalTimeToString() {
    if (widget.totalTime < 60 || widget.totalTime == 0) {
      return "${widget.totalTime}m";
    } else if (widget.totalTime % 60 == 0) {
      return "${(widget.totalTime / 60).floor()}h";
    } else {
      return "${(widget.totalTime / 60).floor()}h ${widget.totalTime % 60}m";
    }
  }

  double getTextHeight(String text) {

    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    final bottomNavHeight = (screenHeight - safeAreaHeight) * 0.075;
    final height = screenHeight - safeAreaHeight - bottomNavHeight;
    final width = MediaQuery.of(context).size.width;
    final commonRatio = (width + height) / 2;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: height * 0.025,
          fontWeight: FontWeight.w500,
          color: gray,
        ),
      ),
      maxLines: null,
      textDirection: ui.TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: MediaQuery.of(context).size.width - commonRatio * 0.04 * 4);

    return textPainter.size.height;
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
              child: Padding(
                padding: EdgeInsets.only(right: commonRatio * 0.04, left: commonRatio * 0.04),
                child: Hero(
                  tag: 'templateCard',
                  child: Container(
                    constraints: BoxConstraints.expand(height: height * 0.22 + getTextHeight(widget.notes)),
                    margin: EdgeInsets.only(bottom: commonRatio * 0.04),
                    padding: EdgeInsets.only(right: commonRatio * 0.04, top: commonRatio * 0.04, left: commonRatio * 0.04,),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: boxShadow,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  widget.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: headerTextStyle
                              ),
                              Text(
                                  totalTimeToString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: headerTextStyle
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 5,
                            ),
                            color: lightGray,
                            height: height * 0.005,
                            width: width * 0.75,
                          ),
                          Flexible(
                            child: SizedBox(
                              height: commonRatio * 0.04,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: widget.isDay
                                        ? Text('Day Drive', overflow: TextOverflow.clip, style: normalTextStyle,)
                                        : Text('Night Drive', overflow: TextOverflow.clip, style: normalTextStyle,),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '${widget.weather} Weather',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: normalTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: getTextHeight(widget.notes),
                            alignment: Alignment.topLeft,
                            child: Text(
                                widget.notes,
                                overflow: TextOverflow.visible,
                                style: normalTextStyle
                            ),
                          ),
                          ClipRect(
                            clipBehavior: Clip.none,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    setState(() {});
                                    Hive.box('TemplateData').deleteAt(widget.boxIndex);
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.delete_rounded, size: commonRatio * 0.04, color: gray),
                                  label: Text("Delete", style: normalTextStyle),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LogEditor(
                                        logEditType: "EditTemplate",
                                        title: widget.title,
                                        weather: widget.weather,
                                        totalTime: widget.totalTime,
                                        notes: widget.notes,
                                        boxIndex: widget.boxIndex,
                                      )),
                                    );
                                    reloadInformation();
                                  },
                                  icon: Icon(Icons.edit_rounded, size: commonRatio * 0.04, color: gray),
                                  label: Text("Edit", style: normalTextStyle),
                                ),
                                SizedBox(
                                  height: height * 0.06,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      addLogInfo();
                                    },
                                    icon: Icon(Icons.add, size: commonRatio * 0.04),
                                    label: const Text("Log Drive"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: accent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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