import 'package:flutter/material.dart';
import 'package:gti_sesa_saude/ui/passo01.dart';
import 'package:gti_sesa_saude/ui/passo02.dart';
import 'package:gti_sesa_saude/ui/passo03.dart';
import 'package:gti_sesa_saude/ui/passo04.dart';
import 'package:gti_sesa_saude/ui/passo05.dart';

class Principal extends StatefulWidget {
  Principal({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  PageController _pageController;  
  String _title = "App Saúde Prefeitura de Serra ES";
  Color _appBarColor = Color.fromRGBO(41, 84, 142, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text(_title),
          backgroundColor: _appBarColor,
          actions: <Widget>[
            Image.asset(
              "img/logo_icon.png",
              width: 50,
            )
          ]),
      body: PageView(
        pageSnapping: true,
        reverse: false,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            child: Center(child: Passo01()),
          ),
          Container(
            child: Center(child: Passo02(paciente:"", pacienteId: "")),
          ),
          Container(
            child: Center(child: Passo03(paciente:"", pacienteId: "",unidadeId: "" )),
          ),
          Container(
            child: Center(child: Passo04(paciente:"", pacienteId: "",unidadeId: "",especialidadeId: "")),
          ),
          Container(
            child: Center(child: Passo05(paciente:"", pacienteId: "",unidadeId: "",especialidadeId: "",consultaId: "",)),
          ),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics:NeverScrollableScrollPhysics()
        
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Image.asset("img/ic_passo01.png", width: 48),
      //       title: Text("Passo"),
      //       backgroundColor: Colors.blue
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset("img/ic_passo02.png", width: 48),
      //       title: Text("Passo"),
      //       backgroundColor: Colors.purple
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset("img/ic_passo03.png", width: 48),
      //       title: Text("Passo"),
      //       backgroundColor: Colors.cyan
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset("img/ic_passo04.png", width: 48),
      //       title: Text("Passo"),
      //       backgroundColor: Colors.pink
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Image.asset("img/ic_passo05.png", width: 48),
      //       title: Text("Passo"),
      //       backgroundColor: Colors.transparent
      //     ),
      //   ],
      //   onTap: navigateToPage,
      //   currentIndex: _page,
      //   fixedColor: Colors.transparent,        
      //   type: BottomNavigationBarType.shifting,
        
      // ),
    );
  }

  void navigateToPage(int page) {
    _pageController.animateToPage(page,
        duration: Duration(milliseconds: 300), curve: Curves.ease);

  }

  void onPageChanged(int page) {
    String _temptitle = "";
    Color _tempColor;
    switch (page) {
      case 0:
        _temptitle = "App Saúde Prefeitura de Serra ES";
        _tempColor = Colors.blue;//Color.fromRGBO(41, 84, 142, 1);
        break;
      case 1:
        _temptitle = "App Saúde Prefeitura de Serra ES";
        _tempColor = Colors.purple;
        break;
      case 2:
        _temptitle = "App Saúde Prefeitura de Serra ES";
        _tempColor = Colors.cyan;
        break;
      case 3:
        _temptitle = "App Saúde Prefeitura de Serra ES";
        _tempColor = Colors.pink
        ;
        break;
      case 4:
        _temptitle = "App Saúde Prefeitura de Serra ES";
        _tempColor = Colors.green;
        break;
    }
    setState(() {
      //this._page = page;
      this._title = _temptitle;
      this._appBarColor = _tempColor;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
