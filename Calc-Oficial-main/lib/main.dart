import 'dart:math';

import 'package:flutter/material.dart';
import 'package:calc_app/comp/CustomAppBar.dart';
import 'package:calc_app/theme/AppTheme.dart';
import './comp/CalcButton.dart';

void main() => runApp(CalcApp());

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});
  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<CalcApp> {
  String valorAnt = '';
  String operador = '';
  TextEditingController _controller = TextEditingController();

  void numClick(String text) {
    setState(() => _controller.text += text);
    print(_controller);
  }

  void clear(String text) {
    setState(() {
      _controller.text = '';
    });
  }

  void opeClick(String text) {
    setState(() {
      valorAnt = _controller.text;
      operador = text;
      _controller.text = '';
    });
  }

  void accion() {
    setState(() {
      print("");
    });
  }

  void resultOperacion(String text) {
    setState(() {
      switch (operador) {
        case "/":
          _controller.text =
              (double.parse(valorAnt) / double.parse(_controller.text)).toString();
          break;
        case "*":
          _controller.text =
              (double.parse(valorAnt) * double.parse(_controller.text)).toString();
          break;
        case "+":
          _controller.text =
              (double.parse(valorAnt) + double.parse(_controller.text)).toString();
          break;
        case "-":
          _controller.text =
              (double.parse(valorAnt) - double.parse(_controller.text)).toString();
          break;
        case "%":
          _controller.text =
              (double.parse(valorAnt) % double.parse(_controller.text)).toString();
          break;
        case "√":
          _controller.text = (sqrt(double.parse(_controller.text))).toString();
          break;
        case "^2":
          _controller.text =
              (pow(double.parse(_controller.text), 2)).toString();
          break;
        case "^":
          _controller.text = (pow(
              double.parse(valorAnt), double.parse(_controller.text)))
              .toString();
          break;
        case "π":
          _controller.text = (pi).toString();
          break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    AppTheme.colorX = Colors.blue;
    List<List> labelList = [
      ["AC", "C", "%", "/"],
      ["7", "8", "9", "*"],
      ["4", "5", "6", "-"],
      ["1", "2", "3", "+"],
      ["√", "^2", "^", "π"],
      [".", "0", "00", "="]
    ];
    List<List> funx = [
      [clear, clear, opeClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [opeClick, opeClick, opeClick, opeClick],
      [numClick, numClick, numClick, resultOperacion]
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: CustomAppBar(accionx: accion as Function),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: _controller,
                ),
              ),
              SizedBox(height: 20),
              ...List.generate(
                labelList.length,
                    (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(
                      labelList[index].length,
                          (indexx) => CalcButton(
                        text: labelList[index][indexx],
                        callback: funx[index][indexx] as Function,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
