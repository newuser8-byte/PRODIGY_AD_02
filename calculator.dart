import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Calculator());
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Container(
      child: RaisedButton(
        onPressed: () => calculation(buttonText),
        child: Text(
          "$buttonText",
          style: TextStyle(fontSize: 30, color: textColor),
        ),
        shape: CircleBorder(),
        color: buttonColor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("AC", Colors.grey, Colors.black),
                buildButton("+/-", Colors.grey, Colors.black),
                buildButton("%", Colors.grey, Colors.black),
                buildButton("/", Colors.amber[700], Colors.black)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("7", Colors.grey[850], Colors.white),
                buildButton("8", Colors.grey[850], Colors.white),
                buildButton("9", Colors.grey[850], Colors.white),
                buildButton("x", Colors.amber[700], Colors.black)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("4", Colors.grey[850], Colors.white),
                buildButton("5", Colors.grey[850], Colors.white),
                buildButton("6", Colors.grey[850], Colors.white),
                buildButton("-", Colors.amber[700], Colors.black)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("1", Colors.grey[850], Colors.white),
                buildButton("2", Colors.grey[850], Colors.white),
                buildButton("3", Colors.grey[850], Colors.white),
                buildButton("+", Colors.amber[700], Colors.black)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: () => calculation("0"),
                  padding: EdgeInsets.fromLTRB(34, 20, 124, 20),
                  shape: StadiumBorder(),
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  color: Colors.grey[850],
                ),
                buildButton(".", Colors.grey[850], Colors.white),
                buildButton("=", Colors.grey[850], Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  dynamic res = '';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic op = '';
  dynamic preOp = '';

  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      res = '';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      op = '';
      preOp = '';
    } else if (op == '=' && btnText == '=') {
      if (preOp == '+') {
        finalResult = add();
      } else if (preOp == '-') {
        finalResult = sub();
      } else if (preOp == 'x') {
        finalResult = mul();
      } else if (preOp == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (op == '+') {        
        finalResult = add();
      } else if (op == '-') {
        finalResult = sub();
      } else if (op == 'x') {
        finalResult = mul();
      } else if (op == '/') {
        finalResult = div();
      }
      preOp = op;
      op = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}