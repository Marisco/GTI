import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/src/enun.dart';

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
          curve: Interval(0.00, 1.00, curve: Curves.ease),
        )),
        child: FadeTransition(opacity: animation, child: child));
  }
}

class SlideRightRouteR<T> extends MaterialPageRoute<T> {
  SlideRightRouteR({WidgetBuilder builder}) : super(builder: builder);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Interval(0.00, 1.00, curve: Curves.ease),
        )),
        child: FadeTransition(opacity: animation, child: child));
  }
}

class AppTextStyle {
  TextStyle getEstiloTexto(TipoTexto tpTexto) {
    switch (tpTexto) {
      case TipoTexto.TITULO:
        return TextStyle(
            color: Colors.white,
            fontFamily: 'Humanist',
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.7)),
            ]);
        break;
      case TipoTexto.CABECALHO:
        return TextStyle(
            color: Colors.white,
            fontFamily: 'Humanist',
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.7)),
            ]);
        break;
      case TipoTexto.CORPO:
        return TextStyle(
          color: Colors.white,
          fontFamily: 'Humanist',
          fontSize: 20,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.7)),
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 5.0,
                color: Colors.black.withOpacity(0.7)),
          ],
        );
        break;
      case TipoTexto.RODAPE:
        return TextStyle(
            color: Colors.white,
            fontFamily: 'Humanist',
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.7)),
            ]);
        break;
      case TipoTexto.ACAO:
        return TextStyle(
            color: Colors.white,
            fontFamily: 'Humanist',
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.7)),
            ]);
        break;
      case TipoTexto.INFERIOR:
        return TextStyle(
            color: Colors.white,
            fontFamily: 'Humanist',
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.7)),
            ]);
      case TipoTexto.LOADING:
        return TextStyle(
            color: Colors.white,
            fontFamily: 'Humanist',
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.7)),
            ]);
        break;
      case TipoTexto.BTNOK:
        return TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Humanist',
          fontSize: 25,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.7)),
            Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.7)),
          ],
        );
        break;
      case TipoTexto.BTNCANCEL:
        return TextStyle(
          color: Colors.red,
          fontFamily: 'Humanist',
          fontSize: 25,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.7)),
            Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Colors.black.withOpacity(0.7)),
          ],
        );
        break;
      default:
        return TextStyle(
            color: Colors.white,
            fontFamily: 'Humanist',
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.7)),
            ]);
    }
  }
}
