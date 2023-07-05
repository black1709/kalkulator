import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  double _result = 0.0;

  void _updateInput(String value) {
    setState(() {
      _input += value;
    });
  }

  void _calculate() {
    setState(() {
      try {
        _result = eval(_input);
      } catch (e) {
        _result = 0.0;
      }
      _input = '';
    });
  }

  double eval(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Color.fromARGB(255, 159, 159, 225),
              child: Text(
                _input,
                style: TextStyle(fontSize: 50.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.black12,
              child: Text(
                _result.toString(),
                style: TextStyle(fontSize: 50.0),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('1', color: Colors.black),
              _buildButton('2', color: Colors.black),
              _buildButton('3', color: Colors.black),
              _buildButton('/', color: Colors.black),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', color: Colors.black),
              _buildButton('5', color: Colors.black),
              _buildButton('6', color: Colors.black),
              _buildButton('*', color: Colors.black),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('7', color: Colors.black),
              _buildButton('8', color: Colors.black),
              _buildButton('9', color: Colors.black),
              _buildButton('-', color: Colors.black),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('.', color: Colors.black),
              _buildButton('0', color: Colors.black),
              _buildButton('C', color: Colors.orange),
              _buildButton('+', color: Colors.black),
            ],
          ),
          ElevatedButton(
            child: Text('Calculate'),
            onPressed: _calculate,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {Color color = Colors.white}) {
    return Expanded(
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 40.0),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        onPressed: () => _updateInput(text),
      ),
    );
  }
}
