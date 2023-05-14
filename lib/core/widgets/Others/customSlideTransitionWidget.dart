import 'package:flutter/material.dart';

class CustomSlideTransitionWidget extends StatefulWidget {
  Widget child;
  Offset offset;
  int delay;

  CustomSlideTransitionWidget({required this.child,this.offset=const Offset(1, 0),this.delay=750});

  @override
  State<CustomSlideTransitionWidget> createState() => _CustomSlideTransitionWidgetState();
}

class _CustomSlideTransitionWidgetState extends State<CustomSlideTransitionWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    _controller=AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.delay)
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  SlideTransition(
              position: Tween<Offset>(begin: widget.offset, end: Offset.zero)
                  .animate(Tween<double>(begin: 0,end:1 ).animate(_controller))
              ,child:widget.child
          );
        }

  }
