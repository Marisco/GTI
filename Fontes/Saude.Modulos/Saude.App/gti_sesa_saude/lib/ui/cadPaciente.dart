import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:gti_sesa_saude/blocs/insert.bloc.dart';
import 'package:gti_sesa_saude/models/insert.model.dart';
import 'package:gti_sesa_saude/blocs/bairro.bloc.dart';
import 'package:gti_sesa_saude/models/bairro.model.dart';
import 'package:gti_sesa_saude/src/formatacao.dart';
import 'package:gti_sesa_saude/widgets/mensagem.dialog.dart';

class CadPaciente extends StatelessWidget {
  final String documento;
  final String dataNascimento;
  CadPaciente({this.documento, this.dataNascimento});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTI-SESA',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color.fromARGB(1, 41, 84, 142),
          hintColor: Colors.white),
      home: _CadPaciente(
          documento: this.documento, dataNascimento: this.dataNascimento),
    );
  }
}

class _CadPaciente extends StatefulWidget {
  final String documento;
  final String dataNascimento;
  _CadPaciente({this.documento, this.dataNascimento});

  @override
  _CadPacienteState createState() => _CadPacienteState(
      documento: this.documento, dataNascimento: this.dataNascimento);
}

class _CadPacienteState extends State<_CadPaciente> {
  final _nome = TextEditingController();
  final _cpf = TextEditingController();
  final _cartaoSus = TextEditingController();
  final _dataNascimento = TextEditingController();
  final _telefone = TextEditingController();
  final String documento;
  final String dataNascimento;
  final focusCpf = FocusNode();
  final focusCns = FocusNode();
  final focusNasc = FocusNode();
  final focusTel = FocusNode();
  var paciente;
  var pacienteId;
  var _paciente = [];
  var _bairros = [];
  String _selBairro;
  double _height = 0.0;

  DialogState _dialogState = DialogState.DISMISSED;
  DateTime selectedDate = DateTime.now();

  int _tpSexo = 0;
  String _dsSexo = "Masculino";
  _CadPacienteState({this.documento, this.dataNascimento});

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("pr_BR", null).then((_) {
      this._dataNascimento.text = this.dataNascimento;
      _cpf.text = this.documento.length == 14 ? this.documento : "";
      _cartaoSus.text = this.documento.length > 14 ? this.documento : "";
      this._dataNascimento.text = this.dataNascimento;
      this._getBairro();
      focusCpf.addListener(_onFocusChange);
      // BackButtonInterceptor.add(myInterceptor);
    });
  }

  @override
  void dispose() {
    _cpf.dispose();
    _cartaoSus.dispose();
    _dataNascimento.dispose();
    BackButtonInterceptor.removeAll();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  void _tpSexoChange(int value) {
    setState(() {
      _tpSexo = value;
      switch (_tpSexo) {
        case 0:
          _dsSexo = "Masculino";
          break;
        case 1:
          _dsSexo = "Feminino";
          break;
      }
    });
  }

  void _getBairro() async {
    BairroModel bairroModel = await bairroBloc.fetchBairros();
    var bairro = bairroModel.getBairros();
    setState(() {
      _bairros = bairro;
    });
  }

  void _postPaciente() async {
    setState(() => _dialogState = DialogState.LOADING);
    InsertModel pacienteModel = await insertBloc.pushPaciente(
        this._nome.text,
        this._cpf.text,
        this._cartaoSus.text,
        this._dataNascimento.text,
        this._dsSexo.substring(0, 1),
        this._telefone.text,
        _selBairro);
    _paciente = pacienteModel.getInsertId();
    
    setState(() {
      _dialogState = DialogState.COMPLETED;
      if (_paciente.isNotEmpty) {
        paciente = this._nome.text;
        pacienteId = _paciente[0].numero.toString();
        _height = 0;
      }
    });
  }

  void _onFocusChange() {
    setState(() {
      _height = MediaQuery.of(context).size.height * 0.30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());              
              setState(() {
                _height = 0;
              });
            },
            child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/passo01.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(children: <Widget>[
                  Row(children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            top: 150, left: 10, right: 10, bottom: 15),
                        //color: Colors.orange,
                        //margin: EdgeInsets.all(25.0),
                        child: Visibility(
                          visible: _dialogState == DialogState.DISMISSED,
                          child: Text(
                            'Não o encotramos  em nossa base de dados. Preencha o formulário abaixo.',
                            style: TextStyle(
                              fontFamily: 'Humanist',
                              color: Colors.white,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ]),
                  Row(// ROW 3
                      children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: _height > 0
                                  ? _height
                                  : MediaQuery.of(context).size.height * 0.62,
                              child: ListView(children: <Widget>[
                                Align(
                                  child: Stack(
                                    children: <Widget>[
                                      Visibility(
                                        visible: _dialogState ==
                                            DialogState.DISMISSED,
                                        child: Container(
                                            color: Colors.blue.withOpacity(0.3),
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Row(children: <Widget>[
                                                    Text(
                                                      'Sexo:',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Humanist',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    Radio(
                                                      value: 0,
                                                      groupValue: _tpSexo,
                                                      onChanged: _tpSexoChange,
                                                      activeColor:
                                                          Color.fromRGBO(
                                                              41, 84, 142, 1),
                                                    ),
                                                    Text(
                                                      'Masculino',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Humanist',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    Radio(
                                                      value: 1,
                                                      groupValue: _tpSexo,
                                                      onChanged: _tpSexoChange,
                                                      activeColor:
                                                          Color.fromRGBO(
                                                              41, 84, 142, 1),
                                                    ),
                                                    Text(
                                                      'Feminino',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Humanist',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  ]),
                                                  Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                              canvasColor: Colors
                                                                  .blue[900]
                                                                  .withOpacity(
                                                                      0.7)),
                                                      child: DropdownButton(
                                                        isDense: false,
                                                        iconSize: 36,
                                                        hint: Text(
                                                          'Bairro onde mora:',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Humanist',
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                  offset:
                                                                      Offset(
                                                                          1.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      3.0,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.7)),
                                                              Shadow(
                                                                  offset:
                                                                      Offset(
                                                                          1.0,
                                                                          1.0),
                                                                  blurRadius:
                                                                      8.0,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.7)),
                                                            ],
                                                          ),
                                                        ),
                                                        value: _selBairro,
                                                        items: _bairros
                                                            .map((bairro) {
                                                          return DropdownMenuItem(
                                                            value:
                                                                bairro.numero,
                                                            child: Text(
                                                              bairro.nome,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Humanist',
                                                                fontSize: 25,
                                                                shadows: <
                                                                    Shadow>[
                                                                  Shadow(
                                                                      offset: Offset(
                                                                          1.0,
                                                                          1.0),
                                                                      blurRadius:
                                                                          3.0,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7)),
                                                                  Shadow(
                                                                      offset: Offset(
                                                                          1.0,
                                                                          1.0),
                                                                      blurRadius:
                                                                          8.0,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7)),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newVal) {
                                                          setState(() {
                                                            _selBairro = newVal;
                                                          });
                                                        },
                                                        style: TextStyle(
                                                          //color: Colors.black,
                                                          fontSize: 20,
                                                        ),
                                                        isExpanded: true,
                                                        elevation: 24,
                                                      )),
                                                  TextField(
                                                    controller: _nome,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSubmitted: (v) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              focusCpf);
                                                    },
                                                    //maxLength: 11,
                                                    decoration: InputDecoration(
                                                      counterText: '',
                                                      labelText:
                                                          "Nome comnpleto:",
                                                      labelStyle: TextStyle(
                                                        fontFamily: 'Humanist',
                                                        color: Colors.white70,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        fontFamily: 'Humanist',
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                    keyboardType:
                                                        TextInputType.text,
                                                  ),
                                                  TextField(
                                                      focusNode: focusCpf,
                                                      controller: _cpf,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onSubmitted: (v) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                focusCns);
                                                      },
                                                      maxLength: 11,
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: '',
                                                        labelText: "Cpf:",
                                                        labelStyle: TextStyle(
                                                          fontFamily:
                                                              'Humanist',
                                                          color: Colors.white70,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Humanist',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        WhitelistingTextInputFormatter
                                                            .digitsOnly,
                                                        FormatarCPF()
                                                      ]),
                                                  TextField(
                                                      focusNode: focusCns,
                                                      controller: _cartaoSus,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onSubmitted: (v) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                focusNasc);
                                                      },
                                                      maxLength: 18,
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: '',
                                                              labelText:
                                                                  "Cartão SUS:",
                                                              labelStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    'Humanist',
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 25,
                                                              )),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Humanist',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        WhitelistingTextInputFormatter
                                                            .digitsOnly,
                                                        FormatarCNS()
                                                      ]),
                                                  TextField(
                                                      controller:
                                                          _dataNascimento,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      focusNode: focusNasc,
                                                      onSubmitted: (v) {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                focusTel);
                                                      },
                                                      maxLength: 10,
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: '',
                                                              labelText:
                                                                  "Data de nascimento:",
                                                              labelStyle: TextStyle(
                                                                fontFamily:
                                                                    'Humanist',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 25,
                                                              )),
                                                      style: TextStyle(fontFamily: 'Humanist', color: Colors.white, fontSize: 20),
                                                      keyboardType: TextInputType.datetime,
                                                      inputFormatters: <TextInputFormatter>[
                                                        WhitelistingTextInputFormatter
                                                            .digitsOnly,
                                                        FormatarData()
                                                      ]),
                                                  TextField(
                                                      controller: _telefone,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      focusNode: focusTel,
                                                      onSubmitted: (v) {
                                                        _postPaciente();
                                                      },
                                                      maxLength: 18,
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: '',
                                                              labelText:
                                                                  "Telefone:",
                                                              labelStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    'Humanist',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 25,
                                                              )),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Humanist',
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        WhitelistingTextInputFormatter
                                                            .digitsOnly,
                                                        FormatarData()
                                                      ]),
                                                ])),
                                      ),
                                      Visibility(
                                        visible: _dialogState !=
                                            DialogState.DISMISSED,
                                        child: Container(
                                            //padding: const EdgeInsets.all(40.0),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                              MensagemDialog(
                                                state: _dialogState,
                                                paciente: this.paciente == null
                                                    ? ""
                                                    : this.paciente,
                                                pacienteId:
                                                    this.pacienteId == null
                                                        ? ""
                                                        : this.pacienteId,
                                                textoTitle:
                                                    this.pacienteId == null
                                                        ? " Aguarde..."
                                                        : " Olá " +
                                                            this.paciente +
                                                            "!",
                                                textoMensagem:
                                                    "Cadastro realizado com sucesso.\nVocê irá se conectar ao Sistema de Saúde da Prefeitura de Serra-ES.\n Aceita o termo e a política de privacidade ?"+
                                                    " SEÇÃO 1 - O QUE FAREMOS COM ESTA INFORMAÇÃO?\n"+
" Quando você realiza alguma transação coletamos as informações pessoais que você nos dá tais como: nome, e-mail e endereço.\n"+
" \n"+
" Quando você acessa nosso app, também recebemos automaticamente o protocolo de internet do seu computador, endereço de IP, a fim de obter informações que nos ajudam a aprender sobre seu navegador e sistema operacional.\n"+
" \n"+
" Email Marketing será realizado apenas caso você permita. Nestes emails você poderá receber notícia sobre nossa loja, novos produtos e outras atualizações.\n"+
" \n"+
" SEÇÃO 2 - CONSENTIMENTO\n"+
" Como vocês obtêm meu consentimento?\n"+
" \n"+
" Quando você fornece informações pessoais como nome, telefone e endereço, para completar: uma transação, verificar seu cartão de crédito, fazer um pedido, providenciar uma entrega ou retornar uma compra. Após a realização de ações entendemos que você está de acordo com a coleta de dados para serem utilizados pela nossa empresa.\n"+
" \n"+
" Se pedimos por suas informações pessoais por uma razão secundária, como marketing, vamos lhe pedir diretamente por seu consentimento, ou lhe fornecer a oportunidade de dizer não.\n"+
" \n"+
" E caso você queira retirar seu consentimento, como proceder?\n"+
" \n"+
" Se após você nos fornecer seus dados, você mudar de ideia, você pode retirar o seu consentimento para que possamos entrar em contato, para a coleção de dados contínua, uso ou divulgação de suas informações, a qualquer momento, entrando em contato conosco em chmarisoc@gmail.com ou nos enviando uma correspondência em: marisco marisco\n"+
" \n"+
" SEÇÃO 3 - DIVULGAÇÃO\n"+
" Podemos divulgar suas informações pessoais caso sejamos obrigados pela lei para fazê-lo ou se você violar nossos Termos de Serviço.\n"+
" \n"+
" SEÇÃO 4 - SERVIÇOS DE TERCEIROS\n"+
" No geral, os fornecedores terceirizados usados por nós irão apenas coletar, usar e divulgar suas informações na medida do necessário para permitir que eles realizem os serviços que eles nos fornecem.\n"+
" \n"+
" Entretanto, certos fornecedores de serviços terceirizados, tais como gateways de pagamento e outros processadores de transação de pagamento, têm suas próprias políticas de privacidade com respeito à informação que somos obrigados a fornecer para eles de suas transações relacionadas com compras.\n"+
" \n"+
" Para esses fornecedores, recomendamos que você leia suas políticas de privacidade para que você possa entender a maneira na qual suas informações pessoais serão usadas por esses fornecedores.\n"+
" \n"+
" Em particular, lembre-se que certos fornecedores podem ser localizados em ou possuir instalações que são localizadas em jurisdições diferentes que você ou nós. Assim, se você quer continuar com uma transação que envolve os serviços de um fornecedor de serviço terceirizado, então suas informações podem tornar-se sujeitas às leis da(s) jurisdição(ões) nas quais o fornecedor de serviço ou suas instalações estão localizados.\n"+
" \n"+
" Como um exemplo, se você está localizado no Canadá e sua transação é processada por um gateway de pagamento localizado nos Estados Unidos, então suas informações pessoais usadas para completar aquela transação podem estar sujeitas a divulgação sob a legislação dos Estados Unidos, incluindo o Ato Patriota.\n"+
" \n"+
" Uma vez que você deixe o site da nossa loja ou seja redirecionado para um aplicativo ou site de terceiros, você não será mais regido por essa Política de Privacidade ou pelos Termos de Serviço do nosso site.\n"+
" \n"+
" Links\n"+
" \n"+
" Quando você clica em links na nossa loja, eles podem lhe direcionar para fora do nosso site. Não somos responsáveis pelas práticas de privacidade de outros sites e lhe incentivamos a ler as declarações de privacidade deles.\n"+
" \n"+
" SEÇÃO 5 - SEGURANÇA\n"+
" Para proteger suas informações pessoais, tomamos precauções razoáveis e seguimos as melhores práticas da indústria para nos certificar que elas não serão perdidas inadequadamente, usurpadas, acessadas, divulgadas, alteradas ou destruídas.\n"+
" \n"+
" Se você nos fornecer as suas informações de cartão de crédito, essa informação é criptografada usando tecnologia secure socket layer (SSL) e armazenada com uma criptografia AES-256. Embora nenhum método de transmissão pela Internet ou armazenamento eletrônico é 100% seguro, nós seguimos todos os requisitos da PCI-DSS e implementamos padrões adicionais geralmente aceitos pela indústria.\n"+
" \n"+
" SEÇÃO 6 - ALTERAÇÕES PARA ESSA POLÍTICA DE PRIVACIDADE\n"+
" Reservamos o direito de modificar essa política de privacidade a qualquer momento, então por favor, revise-a com frequência. Alterações e esclarecimentos vão surtir efeito imediatamente após sua publicação no site. Se fizermos alterações de materiais para essa política, iremos notificá-lo aqui que eles foram atualizados, para que você tenha ciência sobre quais informações coletamos, como as usamos, e sob que circunstâncias, se alguma, usamos e/ou divulgamos elas.\n"+
" \n"+
"Se nossa loja for adquirida ou fundida com outra empresa, suas informações podem ser transferidas para os novos proprietários para que possamos continuar a vender produtos para você.",
                                                textoBtnOK: "Sim",
                                                textoBtnCancel: "Não",
                                                textoState:
                                                    "Registrando usuário no sistema...\n" +
                                                        // " Nome:\n " + this._nome.text +
                                                        " Cpf: " +
                                                        this._cpf.text
                                              )
                                            ])),
                                      )
                                    ],
                                  ),
                                )
                              ]))
                        ],
                      ),
                    ),
                  ]),
                ]))));
  }
}
