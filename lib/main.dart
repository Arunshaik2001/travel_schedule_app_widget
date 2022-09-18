import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    HomeWidget.setAppGroupId('YOUR_GROUP_ID');
    _sendAndUpdate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  _sendData() async {
    try {
      final List<String> placesData = [
        'Mumbai',
        'Delhi',
        'Hyderabad',
      ];
      final List<String> datesData = [
        '4/12/2022',
        '5/12/2022',
        '9/12/2022',
      ];
      return Future.wait([
        HomeWidget.saveWidgetData<String>('placesData', placesData.join(',')),
        HomeWidget.saveWidgetData<String>('datesData', datesData.join(',')),
      ]);
    } on PlatformException catch (exception) {
      debugPrint('Error Sending Data. $exception');
    }
  }

  _updateWidget() async {
    try {
      return HomeWidget.updateWidget(
          name: 'WidgetProvider', androidName: 'WidgetProvider',qualifiedAndroidName: "com.example.travel_schedule_app_widget.widget.WidgetProvider");
    } on PlatformException catch (exception) {
      debugPrint('Error Updating Widget. $exception');
    }
  }

  Future<void> _sendAndUpdate() async {
    await _sendData();
    await _updateWidget();
  }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _launchedFromWidget(Uri? uri) {
    if (uri != null) {
      showDialog(
          context: context,
          builder: (BuildContext buildContext) => AlertDialog(
            title: const Text('App started from HomeScreenWidget'),
            content: Text('Here is the URI: $uri'),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelWidget Example'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Travel Schedule")
          ],
        ),
      ),
    );
  }
}


