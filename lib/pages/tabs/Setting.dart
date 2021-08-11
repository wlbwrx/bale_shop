import 'package:flutter/material.dart';
import '../my_page/MyHome.dart';

class SeetingPage extends StatefulWidget {
  @override
  _SeetingPageState createState() => _SeetingPageState();
}

class _SeetingPageState extends State<SeetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyHome()
    );
  }
}
