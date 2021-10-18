library modern_drawer;

import 'package:flutter/material.dart';

class ModernDrawer extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body;
  final ModernDrawerController controller;
  final Widget? drawerContent;
  final Color? backgroundColor;
  const ModernDrawer({
    Key? key,
    this.appBar,
    required this.controller,
    this.body,
    this.drawerContent,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: _Drawer(drawerContent: drawerContent),
            decoration: BoxDecoration(
              color: backgroundColor ?? Color(0xFF32323F),
            ),
          ),
        ),
        _Body(
          appBar: appBar,
          controller: controller,
          body: body,
        ),
      ],
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, this.appBar, required this.controller, this.body})
      : super(key: key);

  final AppBar? appBar;
  final ModernDrawerController controller;
  final Widget? body;

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

    setState(() {
      _open = true;
    });
  }

  void close() {
    controller.animateBack(0);
    setState(() {
      _open = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(transAnim.value, 0),
      child: Transform.scale(
        scale: scaleAnim.value,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerAnim.value),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 10,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(cornerAnim.value),
            child: GestureDetector(
              onTap: () {
                if (_open) widget.controller.closeDrawer();
              },
              child: AbsorbPointer(
                absorbing: _open,
                child: Scaffold(
                  appBar: widget.appBar,
                  body: widget.body,
                ),
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
  final Widget? drawerContent;
  const _Drawer({Key? key, this.drawerContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: drawerContent ?? Container());
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

  get isOpen => _isOpen;

  void openDrawer() {
    _open();
    _isOpen = true;
  }

  void closeDrawer() {
    _close();
    _isOpen = false;
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
