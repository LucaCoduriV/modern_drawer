library modern_drawer;

import 'package:flutter/material.dart';

class ModernDrawer extends StatelessWidget {
  final AppBar? appBar;
  const ModernDrawer({Key? key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
            child: _Drawer(),
          ),
        ),
        _Body(appBar: appBar)
      ],
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  final AppBar? appBar;

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> with TickerProviderStateMixin {
  bool _open = true;

  late AnimationController controller;
  late Animation<double> transAnim;
  late Animation<double> scaleAnim;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() => setState(() {}));
    transAnim = Tween(begin: 0.0, end: 200.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    scaleAnim = Tween(begin: 1.0, end: 0.7)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(transAnim.value, 0),
      child: Transform.scale(
        scale: scaleAnim.value,
        child: Scaffold(
          appBar: widget.appBar,
          body: Container(
            color: Colors.green,
            child: Center(
              child: Text('Body'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
    );
  }
}
