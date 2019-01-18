import 'package:flutter/material.dart';

class TransicaoTela<T> extends MaterialPageRoute<T> {
  TransicaoTela({WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(opacity: animation, child: child);
  }
}

class SlideRightRoute<T> extends MaterialPageRoute<T> {
  SlideRightRoute({WidgetBuilder builder}) : super(builder: builder);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,

      ).animate(CurvedAnimation(
        parent: animation,
                  curve: Interval(
                    0.00,
                    1.00,
                    curve: Curves.ease                    
                  ),

      ) ) ,
      child: FadeTransition(opacity: animation, child: child)
    );
  }
  
}

