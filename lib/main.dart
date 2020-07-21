import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();
  var infoDados = "Informe seus dados!";
  var formKey = GlobalKey<FormState>();

  void reset() {
    alturaController.text = "";
    pesoController.text = "";
    setState(() {
      infoDados = "Informe seus dados!";
    });
  }

  void calculate() {
    setState(() {
      var altura = double.parse(alturaController.text) / 100;
      var peso = double.parse(pesoController.text);

      var imc = peso / (altura * altura);

      if (imc < 18.5) {
        infoDados = "Abaixo do peso!! IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.5 && imc <= 24.9) {
        infoDados = "Peso normal! IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25 && imc <= 29.9) {
        infoDados = "Sobrepeso! IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30 && imc <= 34.9) {
        infoDados = "Obesidade grau I! IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35 && imc <= 39.9) {
        infoDados = "Obesidade grau II! IMC: ${imc.toStringAsPrecision(4)}";
      } else {
        infoDados = "Obesidade grau III! IMC: ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: reset)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.person,
              color: Colors.green,
              size: 120.0,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Peso(kg)",
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: pesoController,
              validator: (value){
                if(value.isEmpty){
                  return "Insira seu peso ";
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Altura(cm)",
                  labelStyle: TextStyle(color: Colors.green)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: alturaController,
              validator: (value){
                if(value.isEmpty){
                  return "Insira sua altura";
                }

              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: (){
                    if(formKey.currentState.validate()){
                          calculate();
                    }

                  },
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: Colors.green,
                ),
              ),
            ),
            Text(
              infoDados,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 20.0),
            )
          ],
        )),
      ),
    );
  }
}
