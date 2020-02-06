import 'dart:core';
import 'package:easy_dialogs/easy_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';


class Grapher extends StatefulWidget {
  @override
  _GrapherState createState() => _GrapherState(); //remember the a preceding underscore means that the variable is private 
}

class _GrapherState extends State<Grapher> {

  var _tag = ''; //the tag that is currently being shown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DataAnalyzer ToGo'),),
      body:Center(child: SimpleTimeSeriesChart.withSampleData()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.insert_chart),
        onPressed: () {
          //TODO: Some sort of menu or dialog or replace main fragment with dialog for what tags / laps are available
          print('hello');
        },
      ),
    );
  }

  List<dynamic> getDialogItems() {
    //TODO: pull all tags from datamap
  }


  void onDialogSubmitted() {
    //TODO: on dialog submitted create list for chart and update chart
  }

  SingleChoiceDialog<dynamic> getTagDialog() {
    return SingleChoiceDialog<dynamic>(
            title: Text('Phone ringtone'),
            items: getDialogItems(),
            onSelected: (dynamic tag) {
              setState(() => _tag = tag);
            },
    );
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createOtherSampleData(''),
      // Disable animations for image tests.
      animate: false,
    );
  }

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withFile(String url) {
    return new SimpleTimeSeriesChart(
      _createOtherSampleData(url),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }


  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createOtherSampleData(String url) {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<LinearSales, num>> _openFile() {
    return null; //TODO: implement how to retreive data, whether it be from a server or from a file or etc. Maybe use github as a last testing day folder, or maybe use hidden links on the website?
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

/**
 * This enumeration represents all the states that the grapher screen can be in.
 * Possible this should be in the [main.dart] file but I am obviously not experienced enough
 * at the moment. The idea was that the Grapher just changes from one widget to the next.
 * Functionally that can be acheived here (at the time of writing) but perhaps it would be 
 * better to do it in the main, because all main does at the moment is launch grapher.
 * 
 * 
 * 
 * @deprecated but we'll leave it here in case ;)
 */
enum MainState {
  graph,
  histogram
}