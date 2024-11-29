import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget(
      {super.key,
      required this.width,
      required this.duration,
      this.widthIcon = 15,
      this.heightIcon = 15});

  final double width;
  final int duration;
  final double widthIcon;
  final double heightIcon;

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween<double>(
            begin: -widget.widthIcon, end: widget.width + widget.widthIcon)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return SizedBox(
            width: widget.width,
            child: Stack(
              children: [
                Container(
                  height: widget.heightIcon,
                  alignment: Alignment.center,
                  child: const Divider(
                    thickness: 1,
                    height: 0,
                  ),
                ),
                Positioned(
                    left: _animation.value,
                    child: RotatedBox(
                      quarterTurns: 90,
                      child: Container(
                        width: widget.widthIcon,
                        height: widget.heightIcon,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.green),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.electric_bolt,
                          size: 8.r,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
