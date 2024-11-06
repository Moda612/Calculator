import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _displayText = '0';
  String _operand = ''; 
  double _num1 = 0.0;
  double _num2 = 0.0;

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _displayText = '0';
      _operand = '';
      _num1 = 0.0;
      _num2 = 0.0;
    } else if (buttonText == '=') {
      _num2 = double.parse(_displayText);
      double result;

      switch (_operand) {
        case '+':
          result = _num1 + _num2;
          break;
        case '-':
          result = _num1 - _num2;
          break;
        case '*':
          result = _num1 * _num2;
          break;
        case '/':
          if (_num2 == 0) {
            _displayText = 'Error: Division by zero';
            return;
          }
          result = _num1 / _num2;
          break;
        default:
          result = 0.0;
      }

      _displayText = result.toString();
      _operand = '';
      _num1 = result;
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      _num1 = double.parse(_displayText);
      _operand = buttonText;
      _displayText = '';
    } else {
      _displayText += buttonText;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0',
              ),
              style: const TextStyle(fontSize: 24.0),
              textAlign: TextAlign.end,
              readOnly: true,
              controller: TextEditingController(text: _displayText),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton('C'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(buttonText),
      child: Text(buttonText),
    );
  }
}
