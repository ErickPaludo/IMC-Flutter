import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();

  TextEditingController alturaController = TextEditingController();

  String _info = "Informe seuss dados!";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void reset() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      _info = "Informe seuss dados!";
    });
  }

  void calc() {
    if (pesoController.text != null && alturaController.text != null) {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      setState(() {
        if (imc < 18.6) {
          _info = "Abaixo do Peso! (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 18.6 && imc < 24.9) {
          _info = "Peso Ideal! (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 24.9 && imc < 29.9) {
          _info = "Levemente Acima do Peso! (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 29.9 && imc < 34.9) {
          _info = "Obesidade Grau I! (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 34.9 && imc < 39.9) {
          _info = "Obesidade Grau II! (${imc.toStringAsPrecision(4)})";
        } else {
          _info = "Obesidade Grau III! (${imc.toStringAsPrecision(4)})";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Calculadora de Imc",
          style: TextStyle(color: Colors.white),
        ),
        actions: [IconButton(onPressed: reset, icon: Icon(Icons.refresh))],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusColor: Colors.green,
                    labelText: "Peso em kg",
                    labelStyle: TextStyle(color: Colors.green), focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                controller: pesoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura em cm",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  controller: alturaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira sua Altura";
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      if(_formkey.currentState!.validate()){
                        calc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
