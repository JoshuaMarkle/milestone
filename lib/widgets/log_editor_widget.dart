import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widgets/title_popup_widget.dart';
import '../widgets/note_popup_widget.dart';

import '../data.dart';
import '../theme.dart';

List<String> dropdownWeather = <String>["Clear", "Raining", "Snowing", "Foggy"];

class LogEditor extends StatefulWidget {

  final String logEditType;
  final String? title;
  final DateTime? date;
  final String? weather;
  final int? totalTime;
  final String? notes;

  const LogEditor({Key? key,
    required this.logEditType,
    this.title,
    this.date,
    this.weather,
    this.totalTime,
    this.notes,
  }) : super(key: key);

  @override
  State<LogEditor> createState() => _LogEditorState();
}

class _LogEditorState extends State<LogEditor> {

  late String customTitle;
  late bool customIsDate;
  late String customButton;

  late num totalMinutes = startTime.hour * 60 + startTime.minute + (widget.totalTime ?? 0);
  late int hours = totalMinutes ~/ 60;
  late int minutes = totalMinutes.toInt() % 60;
  TimeOfDay startTime = const TimeOfDay(hour: 12, minute: 0);
  late TimeOfDay endTime = startTime.replacing(hour: hours, minute: minutes);
  late DateTime _date = widget.date ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final textController = TextEditingController();
  late String selectedWeather = widget.weather ?? dropdownWeather.first;

  void customLogType() {
    if (widget.logEditType == "Past") {
      customTitle = "Log Past Drive";
      customIsDate = true;
      customButton = "Log Drive";
    } else if (widget.logEditType == "Template") {
      customTitle = "Create Template";
      customIsDate = false;
      customButton = "Create";
    } else if (widget.logEditType == "EditHistory") {
      customTitle = "Edit Past Log";
      customIsDate = true;
      customButton = "Apply Changes";
    } else if (widget.logEditType == "EditTemplate") {
      customTitle = "Edit Template";
      customIsDate = false;
      customButton = "Apply Changes";
    }
  }

  void customOutput(int index, String title, DateTime date, int total, String notes, bool isDay, String weather) {
    if (widget.logEditType == "Past") {
      addLogInfo(date, total, notes, isDay, weather);
    } else if (widget.logEditType == "Template") {
      addTemplateData(title, total, notes, isDay, weather);
    } else if (widget.logEditType == "EditHistory") {
      editHistoryData(index, date, total, notes, isDay, weather);
    } else if (widget.logEditType == "EditTemplate") {
      editTemplateData(index, title, total, notes, isDay, weather);
    }
  }

  void addLogInfo(DateTime date, int total, String notes, bool isDay, String weather) {
    final newData = LogData()
      ..logDate = date
      ..totalTime = total
      ..notes = notes
      ..isDay = isDay
      ..weather = weather;

    final logBox = Hive.box('LoggedData');
    logBox.add(newData);
  }

  void addTemplateData(String title, int total, String notes, bool isDay, String weather) {
    final newData = TemplateData()
      ..title = title
      ..totalTime = total
      ..notes = notes
      ..isDay = isDay
      ..weather = weather;

    final templateData = Hive.box('TemplateData');
    templateData.add(newData);
  }

  void editHistoryData(int index, DateTime date, int total, String notes, bool isDay, String weather) {
    final newData = LogData()
      ..logDate = date
      ..totalTime = total
      ..notes = notes
      ..isDay = isDay
      ..weather = weather;

    final logBox = Hive.box("LoggingData");
    logBox.putAt(index, newData);
  }

  void editTemplateData(int index, String title, int total, String notes, bool isDay, String weather) {
    final newData = TemplateData()
      ..title = title
      ..totalTime = total
      ..notes = notes
      ..isDay = isDay
      ..weather = weather;

    final logBox = Hive.box("TemplateData");
    logBox.putAt(index, newData);
  }

  void selectDate() async {
    FocusScope.of(context).unfocus();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 730)),
      lastDate: DateTime.now(),
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  void selectStartTime() async {
    final newStartTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (newStartTime != null) {
      setState(() {
        startTime = newStartTime;
      });
    }
  }
  void selectEndTime() async {
    final newEndTime = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (newEndTime != null) {
      setState(() {
        endTime = newEndTime;
      });
    }
  }

  int calculateTotalTime() {
    var resultHour = 0;
    var resultMinute = 0;
    if(endTime.minute >= startTime.minute) {
      resultMinute = endTime.minute - startTime.minute;
      if(endTime.hour >= startTime.hour) {
        resultHour = endTime.hour - startTime.hour;
      }else {
        resultHour = (endTime.hour - startTime.hour) + 24;
      }
    }else {
      resultMinute = (endTime.minute + 60) - startTime.minute;
      if((endTime.hour - 1) >= startTime.hour) {
        resultHour = (endTime.hour - 1) - startTime.hour;
      }else {
        resultHour = ((endTime.hour - 1) - startTime.hour) + 24;
      }
    }
    return resultHour * 60 + resultMinute;
  }
  String totalTimeToString(int totalTime) {
    if (totalTime < 60 || totalTime == 0) {
      return "${totalTime}m";
    } else if (totalTime % 60 == 0) {
      return "${(totalTime / 60).floor()}h";
    } else {
      return "${(totalTime / 60).floor()}h ${totalTime % 60}m";
    }
  }

  bool isDayFinder() {
    if (endTime.hour >= 18 || endTime.hour <= 6) {
      return false;
    }
    return true;
  }

  String templateTitle() {
    if (titleNotes.isNotEmpty) {
      return titleNotes;
    }
    return "Untitled";
  }
  String notesTaken() {
    if (notes.isNotEmpty) {
      return notes;
    }
    return "No notes taken.";
  }

  @override
  void initState() {
    super.initState();
    titleNotes = widget.title ?? "";
    notes = widget.notes ?? "";
    customLogType();
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

    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: transparentTint,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ), /// Touchable Background
          SafeArea(
            child: Container(
              height: height / 1.3,
              width: double.infinity,
              margin: EdgeInsets.all(commonRatio * 0.04),
              padding:  EdgeInsets.all(commonRatio * 0.04),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(customTitle, style: headerTextStyle),
                  ), /// Title
                  customIsDate
                      ? Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: selectDate,
                          child: Container(
                            color: white,
                            child: Row(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    constraints: const BoxConstraints.expand(),
                                    decoration: BoxDecoration(
                                        color: accent,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Icon(
                                            Icons.calendar_today_rounded,
                                            color: specialWhite,
                                            size: constraints.maxHeight * 0.5,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: commonRatio * 0.04,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Date', style: headerTextStyle),
                                      ),
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('${_date.month}/${_date.day}/${_date.year}', style: normalTextStyle),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      )
                  ) /// Date
                      : const Expanded(
                    flex: 1,
                    child: TitleWidget(),
                  ), /// Add Title
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: white,
                            child: Row(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    constraints: const BoxConstraints.expand(),
                                    decoration: BoxDecoration(
                                        color: accent,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Icon(
                                            Icons.cloud_rounded,
                                            color: specialWhite,
                                            size: constraints.maxHeight * 0.5,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: commonRatio * 0.04,),
                                Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Weather', style: headerTextStyle),
                                        ),
                                        Flexible(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: DropdownButton<String>(
                                              value: selectedWeather,
                                              style: normalTextStyle,
                                              underline: Container(),
                                              icon: Icon(
                                                Icons.keyboard_arrow_right_rounded,
                                                color: gray,
                                              ),
                                              onChanged: (String? newValue){
                                                setState(() {
                                                  selectedWeather = newValue!;
                                                });
                                              },
                                              items: dropdownWeather.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                      )
                  ), /// Weather
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Container(
                            constraints: const BoxConstraints.expand(),
                            decoration: BoxDecoration(
                                color: accent,
                                shape: BoxShape.circle
                            ),
                            child: Center(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Icon(
                                    Icons.timer_rounded,
                                    color: specialWhite,
                                    size: constraints.maxHeight * 0.5,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: commonRatio * 0.04,),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: selectStartTime,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text('Start Time', style: headerTextStyle),
                                      ),
                                      Flexible(
                                        child: Text('${startTime.format(context)}', style: normalTextStyle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: commonRatio * 0.04,),
                              Expanded(
                                child: GestureDetector(
                                  onTap: selectEndTime,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text('End Time', style: headerTextStyle),
                                      ),
                                      Flexible(
                                        child: Text('${endTime.format(context)}', style: normalTextStyle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), /// Start End Time
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text('Total Time', style: headerTextStyle),
                          ),
                          Flexible(
                            child: Text(totalTimeToString(calculateTotalTime()), style: normalTextStyle),
                          ),
                        ],
                      )
                  ), /// Total Time
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  const Expanded(
                    flex: 2,
                    child: NoteWidget(),
                  ), /// Notes
                  SizedBox(height: commonRatio * 0.04,), /// Spacer
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.clear, size: commonRatio * 0.04, color: gray),
                          label: Text("Cancel", style: normalTextStyle),
                        ),
                        SizedBox(
                          height: height * 0.06,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              customOutput(0, templateTitle(), _date, calculateTotalTime(), notesTaken() , isDayFinder(), selectedWeather);
                              Navigator.pop(context, () {
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.add, size: commonRatio * 0.04),
                            label: Text(customButton),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), /// Bottom Buttons
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}