import 'dart:ui' as ui;

import 'package:Milestone/widgets/log_editor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../data.dart';
import '../theme.dart';


class HistoryCards extends StatelessWidget {
  const HistoryCards({Key? key}) : super(key: key);

  Widget _buildListView() {
    final logBox = Hive.box('LoggedData');
    return AnimationLimiter(
        child: ValueListenableBuilder(
            valueListenable: Hive.box('LoggedData').listenable(),
            builder: (context, box, child) => ListView.builder(
              itemCount: logBox.length,
              itemBuilder: (BuildContext context, int index) {
                final data = logBox.getAt(index) as LogData;
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(milliseconds: 2500),
                      child: HistoryCard(
                        dateTime: DateFormat('MM/dd/yyyy').format(data.logDate),
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


class HistoryCard extends StatefulWidget {
  final String dateTime;
  final int totalTime;
  final String notes;
  final bool isDay;
  final String weather;
  final int boxIndex;

  const HistoryCard(
      {Key? key,
        required this.dateTime,
        required this.totalTime,
        required this.notes,
        required this.isDay,
        required this.weather,
        required this.boxIndex})
      : super(key: key);

  @override
  HistoryCardState createState() => HistoryCardState();
}

class HistoryCardState extends State<HistoryCard> {

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

    return Hero(
      tag: 'historyCard',
      child: Padding(
        padding: EdgeInsets.only(right: commonRatio * 0.04, left: commonRatio * 0.04),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return HistoryCardPopup(
                dateTime: widget.dateTime,
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
                          widget.dateTime,
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



class HistoryCardPopup extends StatefulWidget {
  final String dateTime;
  final int totalTime;
  final String notes;
  final bool isDay;
  final String weather;
  final int boxIndex;

  const HistoryCardPopup(
      {Key? key,
        required this.dateTime,
        required this.totalTime,
        required this.notes,
        required this.isDay,
        required this.weather,
        required this.boxIndex})
      : super(key: key);

  @override
  HistoryCardPopupState createState() => HistoryCardPopupState();
}

class HistoryCardPopupState extends State<HistoryCardPopup> {

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
                  tag: 'historyCard',
                  child: Container(
                    constraints: BoxConstraints.expand(height: height * 0.2 + getTextHeight(widget.notes)),
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
                                  widget.dateTime,
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
                                    Hive.box('LoggedData').deleteAt(widget.boxIndex);
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.delete_rounded, size: commonRatio * 0.04, color: gray),
                                  label: Text("Delete", style: normalTextStyle),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        barrierDismissible: true,
                                        pageBuilder: (_, __, ___) => LogEditor(
                                          logEditType: "EditHistory",
                                          date: DateFormat('MM/dd/yyyy').parse(widget.dateTime),
                                          weather: widget.weather,
                                          totalTime: widget.totalTime,
                                          boxIndex: widget.boxIndex,
                                        ),
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
                                  icon: Icon(Icons.edit_rounded, size: commonRatio * 0.04, color: gray),
                                  label: Text("Edit", style: normalTextStyle),
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