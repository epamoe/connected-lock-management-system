import 'dart:async';

import 'package:flutter/material.dart';

import 'color_constants.dart';

class LockCircleCardWidget extends StatefulWidget {
  final String iconImg;
  final String nameTxt;
  final Duration? delayStart;
  final VoidCallback onPressed;

  LockCircleCardWidget(
      {required this.iconImg,
      required this.nameTxt,
      this.delayStart,
      required this.onPressed})
      : super();

  @override
  _LockCircleCardWidgetState createState() => _LockCircleCardWidgetState();
}

class _LockCircleCardWidgetState extends State<LockCircleCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    Timer(widget.delayStart!, () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: widget.onPressed,
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Image.asset(
                    widget.iconImg,
                    height: 25,
                    width: 25,
                    color: Color(0XFF203782),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              widget.nameTxt,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 12,
                    color: primaryColor,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
