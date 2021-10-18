library modern_drawer;

import 'package:flutter/material.dart';

class ModernDrawer extends StatelessWidget {
  final AppBar? appBar;
  final ModernDrawerController controller;
  const ModernDrawer({Key? key, this.appBar, required this.controller})
      : super(key: key);

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
        _Body(appBar: appBar, controller: controller),
      ],
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    this.appBar,
    required this.controller,
  }) : super(key: key);

  final AppBar? appBar;
  final ModernDrawerController controller;

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> with TickerProviderStateMixin {
  bool _open = true;

  late AnimationController controller;
  late Animation<double> transAnim;
  late Animation<double> scaleAnim;
  late Animation<double> cornerAnim;

  @override
  void initState() {
    super.initState();

    widget.controller.close = close;
    widget.controller.open = open;

    controller = new AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() => setState(() {}));
    transAnim = Tween(begin: 0.0, end: 200.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    scaleAnim = Tween(begin: 1.0, end: 0.7)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    cornerAnim = Tween(begin: 0.0, end: 20.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    controller.forward();
  }

  void open() {
    controller.forward();
    _open = true;
  }

  void close() {
    controller.animateBack(0);
    _open = false;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(transAnim.value, 0),
      child: Transform.scale(
        scale: scaleAnim.value,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerAnim.value),
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

class ModernDrawerController {
  late final Function _open;
  late final Function _close;
  bool _isOpen = false;

  set open(Function func) {
    _open = func;
  }

  set close(Function func) {
    _close = func;
  }

  void openDrawer() {
    _open();
  }

  void closeDrawer() {
    _close();
  }

  void toggleDrawer() {
    if (_isOpen) {
      closeDrawer();
      _isOpen = false;
    } else {
      openDrawer();
      _isOpen = true;
    }
  }
}
