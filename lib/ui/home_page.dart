import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/notification_service.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  NotifyHelper? _notifyHelper;

  @override
  void initState() {
    super.initState();
    _notifyHelper = NotifyHelper();
    _notifyHelper?.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Text(
            "Theme Data",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () async {
          ThemeService().switchTheme();
          _notifyHelper?.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activate Light Theme"
                  : "Activated Dark Theme");
          _notifyHelper?.scheduledNotification("Schedule", 3);
        },
        child: Icon(
          (ThemeService().theme == ThemeMode.dark)
              ? Icons.wb_sunny_rounded
              : Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
