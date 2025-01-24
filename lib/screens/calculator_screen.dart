import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';git

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      }else if(value == 'del'){
        if(input.isNotEmpty){
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '=') {
        try {
          result = evalExpression(input).toString();
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  double evalExpression(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression.replaceAll('x', '*'));
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  Widget buildButton(String label, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => buttonPressed(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade300, // Light gray button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          elevation: 6, // Shadow for buttons
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF567BB2),
    title: Padding(
    padding: const EdgeInsets.only(top: 10.0),
        child: Text('CALCULATOR', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),),),
        centerTitle: true,

      ),
      body: Padding(
    padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          // Display Area
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(input, style: TextStyle(fontSize: 36, color: Colors.black54)),
                  Text(result, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
          ),
          // Button Area
          Expanded(
            flex: 5,
            child: Container(
              color: Color(0xFF567BB2),
              padding: EdgeInsets.all(16), // Padding around the button area
              child: Column(
                children: [
                  // Row 1: +, C
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton('del', 185, 88),
                      SizedBox(width: 7),
                      buildButton('C', 185, 88),
                    ],
                  ),
                  SizedBox(height: 7),
                  // Row 2: 7, 8, 9, -
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton('7', 88, 88),
                      SizedBox(width: 7),
                      buildButton('8', 88, 88),
                      SizedBox(width: 7),
                      buildButton('9', 88, 88),
                      SizedBox(width: 7),
                      buildButton('+', 88, 88),
                    ],
                  ),
                  SizedBox(height: 7),
                  // Row 3: 4, 5, 6, x
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton('4', 88, 88),
                      SizedBox(width: 7),
                      buildButton('5', 88, 88),
                      SizedBox(width: 7),
                      buildButton('6', 88, 88),
                      SizedBox(width: 7),
                      buildButton('-', 88, 88),
                    ],
                  ),
                  SizedBox(height: 7),
                  // Row 4: 1, 2, 3, =
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton('1', 88, 88),
                      SizedBox(width: 7),
                      buildButton('2', 88, 88),
                      SizedBox(width: 7),
                      buildButton('3', 88, 88),
                      SizedBox(width: 7),
                      buildButton('x', 88, 88), // "=" button is taller
                    ],
                  ),
                  SizedBox(height: 7),
                  // Row 5: ., 0, /
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton('.', 88, 88),
                      SizedBox(width: 7),
                      buildButton('0', 88, 88),
                      SizedBox(width: 7),
                      buildButton('/', 88, 88),
                      SizedBox(width: 7),
                      buildButton('=', 88, 88),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
