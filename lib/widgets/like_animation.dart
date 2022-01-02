import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final bool smallLike;
  final VoidCallback? onEnd;

  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  }) : super(key: key);

  @override
  _LikeAnimationState createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController likeController;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    likeController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds ~/ 2,
      ),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(likeController);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
   if(widget.isAnimating || widget.smallLike) {
     await likeController.forward();
     await likeController.reverse();
     await Future.delayed(const Duration(milliseconds: 200,),);

     if(widget.onEnd != null) {
       widget.onEnd!();
     }
   }
  }

  @override
  void dispose() {
    super.dispose();
    likeController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: scale, child: widget.child,);
  }
}
