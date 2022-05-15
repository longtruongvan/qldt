import 'package:flutter/material.dart';

class SystemManagerNotification extends StatefulWidget {
  const SystemManagerNotification({Key? key}) : super(key: key);

  @override
  State<SystemManagerNotification> createState() => _SystemManagerNotificationState();
}

class _SystemManagerNotificationState extends State<SystemManagerNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.green,),
    );
  }
}
