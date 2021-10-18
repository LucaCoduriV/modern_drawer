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
        bodyBoxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              controller.toggleDrawer();
            },
          ),
          title: Text('Modern Drawer'),
        ),
        drawerContent: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("coucou"),
            Text("coucou"),
            Text("coucou"),
            Text("coucou"),
            Text("coucou"),
            Text("coucou"),
          ],
        ),
        body: Container(
          color: Colors.green,
          child: Center(
            child: Text('Body'),
          ),
        ),
      ),
    );
  }
}
