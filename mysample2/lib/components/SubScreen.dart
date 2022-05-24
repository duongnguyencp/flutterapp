import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubScreen extends StatefulWidget {
  const SubScreen({Key? key}) : super(key: key);

  @override
  State<SubScreen> createState() => _SubScreenState();
}

class _SubScreenState extends State<SubScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
  }

  void toggle() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  final double maxSlide = 225.0;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double minDragStartEdge = 25;
  double maxDragStartEdge = 25;
  bool _canBeDragged = false;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta= details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }
  void _onDragEnd(DragEndDetails details){
    if(animationController.isDismissed || animationController.isCompleted){
      return;
    }
    if(details.velocity.pixelsPerSecond.dx.abs() >= 365.0){
      double visualVelocity= details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    }
    else if(animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }
  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(color: Colors.blue);
    var myChild = Container(color: Colors.yellow);
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          double slide = maxSlide * animationController.value;
          double scale = (animationController.value * 0.3);
          return Stack(
            children: [
              myDrawer,
              Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: myChild),
            ],
          );
        },
      ),
    );
  }

  void close() {}

  void open() {}
}
