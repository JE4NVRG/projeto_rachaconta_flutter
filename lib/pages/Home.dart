// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//Variaveis
  double taxa = 0.0;
  late double totalconta, totalpagar, Comissao;
  late int qtdpessoas;

  //Criando os TextControllers
  //Criando os TextControllers
  TextEditingController txttotal = TextEditingController();
  TextEditingController txtqtd = TextEditingController();
  //criando a chave do form
  final _formkey = GlobalKey<FormState>();

  late double comissao;

  //metodo que calcula

  void calcularConta() {
    //1 passo receber o valores
    setState(() {
      totalconta = double.parse(txttotal.text);
      qtdpessoas = int.parse(txtqtd.text);

      //2 passo -  calcular a comissao do garcon
      comissao = (taxa * totalconta) / 100;

      // 3 passo - calcular o total por pessoa
      totalpagar = (totalconta + comissao) / qtdpessoas;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Total a pagar por Pessoa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/smile.png', width: 60),
              Text('O Total da Conta: R\$$totalconta'),
              Text('Taxa do Garcon: R\$$comissao'),
              Text('O Total Por Pessoa: R\$$totalpagar'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Racha Conta'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: SingleChildScrollView(
          // para o teclado nao dar erro quando abrir a imagem ficar com scroll
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: txttotal,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Total da Conta"),
                      style: TextStyle(fontSize: 18),
                      validator: (valor) {
                        if (valor!.isEmpty)
                          return 'Campo obrigatorio';
                        else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Taxa de Servicos %:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Slider(
                          value: taxa,
                          min: 0,
                          max: 10,
                          label: '$taxa%',
                          divisions: 10,
                          activeColor: Colors.greenAccent,
                          inactiveColor: Colors.grey,
                          onChanged: (double valor) {
                            setState(() {
                              taxa = valor;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      controller: txtqtd,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: "Qtd Pessoas",
                      ),
                      style: TextStyle(fontSize: 18),
                      validator: (valor) {
                        if (valor!.isEmpty)
                          return 'Campo obrigatorio';
                        else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          child: Text(
                            'Calcular',
                            style: TextStyle(fontSize: 25),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              calcularConta();
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
