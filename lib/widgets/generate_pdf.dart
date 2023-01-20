import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void generatePdfFromHiveData(BuildContext context) async {
  final pdf = pw.Document();
  final regular =
      pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
  final bold =
      pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));
  final titleStyle = pw.TextStyle(font: bold, fontSize: 18);
  final headerStyle = pw.TextStyle(font: bold, fontSize: 12);
  final textStyle = pw.TextStyle(font: regular, fontSize: 12);

  dynamic totalTime = 0;
  dynamic totalDayTime = 0;
  dynamic totalNightTime = 0;

  final logBox = Hive.box('LoggedData');
  for (var log in logBox.values) {
    totalTime += log.totalTime;
    if (log.isDay) {
      totalDayTime += log.totalTime;
    } else {
      totalNightTime += log.totalTime;
    }
  }
  List<List<dynamic>> totals = [
    [totalTime, totalDayTime, totalNightTime]
  ];

  const headers = ['Date', 'Minutes Driven', 'Day/Night', 'Weather'];
  final rows = logBox.values
      .map((logData) => [
            DateFormat('MM/dd/yyyy').format(logData.logDate),
            logData.totalTime.toString(),
            logData.isDay ? 'Day' : 'Night',
            logData.weather,
          ])
      .toList();

  var pdfData = pdf.save();
  await Printing.layoutPdf(
    name: "Driving Log Sheet",
    onLayout: (_) => pdfData,
  );
}
