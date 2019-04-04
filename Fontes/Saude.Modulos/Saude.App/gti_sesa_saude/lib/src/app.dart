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

class SlideLeftRoute<T> extends MaterialPageRoute<T> {
  SlideLeftRoute({WidgetBuilder builder}) : super(builder: builder);
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
            fontSize: 25,
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.7)),
              Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
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
          fontSize: 30,
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
          //fontFamily: 'Humanist',
          fontSize: 15,
          // shadows: <Shadow>[
          //   Shadow(
          //       offset: Offset(1.0, 1.0),
          //       blurRadius: 3.0,
          //       color: Colors.black.withOpacity(0.7)),
          //   Shadow(
          //       offset: Offset(1.0, 1.0),
          //       blurRadius: 5.0,
          //       color: Colors.black.withOpacity(0.7)),
          // ]
        );
        break;
      case TipoTexto.ACAO:
        return TextStyle(
          color: Colors.black,
          //fontFamily: 'Humanist',
          fontSize: 10,
          // shadows: <Shadow>[
          //   Shadow(
          //       offset: Offset(1.0, 1.0),
          //       blurRadius: 3.0,
          //       color: Colors.black.withOpacity(0.7)),
          //   Shadow(
          //       offset: Offset(1.0, 1.0),
          //       blurRadius: 5.0,
          //       color: Colors.black.withOpacity(0.7)),
          // ]
        );
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
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0,
                color: Colors.black.withOpacity(0.7)),
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0,
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
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0,
                color: Colors.black.withOpacity(0.7)),
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0,
                color: Colors.black.withOpacity(0.7)),
          ],
        );
        break;
      case TipoTexto.RADIO:
        return TextStyle(
          fontFamily: 'Humanist',
          color: Colors.white,
          fontSize: 20,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromRGBO(41, 84, 142, 9.9)),
            Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromRGBO(41, 84, 142, 9.9)),
          ],
        );
        break;
      case TipoTexto.PLACEHOLDER:
        return TextStyle(
            fontFamily: 'Humanist',
            color: Colors.white70,
            fontSize: 20,
            letterSpacing: 2.5);
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
