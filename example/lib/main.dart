import 'package:flutter/material.dart';
import 'package:modern_drawer/modern_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ModernDrawer(
        appBar: AppBar(
          title: Text('Modern Drawer'),
        ),
      ),
    );
  }
}
