library image_animation_devfest;

import 'package:flutter/material.dart';

class ImageAnimation extends StatefulWidget {
  String? imgPath;
  double? begin, end;
  ImageAnimation({Key? key, @required this.imgPath, this.begin, this.end})
      : super(key: key);

  @override
  _ImageAnimationState createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    // TODO: implement initState

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller!.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller!.forward();
            }
          });
    animation =
        Tween<double>(begin: widget.begin ?? 0.0, end: widget.end ?? 250.0)
            .animate(controller!);

    controller!.forward();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: animation!.value,
      width: animation!.value,
      child: Image.asset(widget.imgPath!),
    ));
  }
}
