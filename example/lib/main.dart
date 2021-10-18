import 'package:flutter/material.dart';
import 'package:modern_drawer/modern_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = ModernDrawerController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ModernDrawer(
        controller: controller,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              controller.toggleDrawer();
            },
          ),
          title: Text('Modern Drawer'),
        ),
      ),
    );
  }
}
