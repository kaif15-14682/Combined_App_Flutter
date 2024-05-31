import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:fl_chart/fl_chart.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<String> operators = ["+", "-", "×", "÷"];
  List<String> hist = [];
  List<String> historyList = [];
  var history = "", output = "0";
  bool isDarkMode = false;

  void _numClick(String text) {
    setState(() {
      if (output == "0") {
        output = text;
      } else {
        output += text;
      }
    });
  }

  void clear() {
    setState(() {
      history = "";
      output = "0";
      hist = [];
    });
  }

  void back() {
    setState(() {
      if (output.length > 1) {
        output = output.substring(0, output.length - 1);
      } else {
        output = "0";
      }
    });
  }

  void sign() {
    setState(() {
      if (output != "0") {
        if (output.startsWith('-')) {
          output = output.substring(1);
        } else {
          output = '-' + output;
        }
      }
    });
  }

  void percent() {
    setState(() {
      double value = double.parse(output) / 100;
      output = value.toString();
      hist.clear();
      history = "percent";
    });
  }

  void _operatorClick(String operator) {
    setState(() {
      hist.add(output);
      hist.add(operator);
      history = hist.join(" ");
      output = "0";
    });
  }

  void equals() {
    setState(() {
      hist.add(output);
      String expression =
          hist.join(" ").replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      output = eval.toString();
      history = hist.join(" ") + " = $output";
      historyList.add(history);
      hist.clear();
    });
  }

  void clickDot() {
    setState(() {
      if (!output.contains(".")) {
        output += ".";
      }
    });
  }

  void toggleMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void showHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Calculation History"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(historyList[index]),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showConverter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Converter"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                child: Text("Length Converter"),
                onPressed: () {
                  Navigator.of(context).pop();
                  showLengthConverter();
                },
              ),
              ElevatedButton(
                child: Text("Weight Converter"),
                onPressed: () {
                  Navigator.of(context).pop();
                  showWeightConverter();
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showLengthConverter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LengthConverterDialog();
      },
    );
  }

  void showWeightConverter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WeightConverterDialog();
      },
    );
  }

  void showGraphPlotter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GraphPlotterDialog();
      },
    );
  }

  void _scientificClick(String func) {
    setState(() {
      Parser p = Parser();
      Expression exp = p.parse(func + '(' + output + ')');
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      output = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent.shade400,
          title: Text('Calculator'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.history),
              onPressed: showHistory,
            ),
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
              onPressed: toggleMode,
            ),
            IconButton(
              icon: Icon(Icons.swap_horiz),
              onPressed: showConverter,
            ),
            IconButton(
              icon: Icon(Icons.show_chart),
              onPressed: showGraphPlotter,
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0, right: 15.0),
                child: Text(
                  "$history",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w200,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, right: 15.0, bottom: 15.0),
                child: Text(
                  "$output",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("C", clear, Colors.deepOrangeAccent.shade400),
                    _buildButton("±", sign, Colors.deepOrangeAccent.shade400),
                    _buildButton(
                        "%", percent, Colors.deepOrangeAccent.shade400),
                    _buildButton("÷", () => _operatorClick("÷"), Colors.white,
                        Colors.deepOrangeAccent.shade400),
                  ],
                ),
              ),
              _buildNumberRow(["1", "2", "3", "×"]),
              _buildNumberRow(["4", "5", "6", "-"]),
              _buildNumberRow(["7", "8", "9", "+"]),
              _buildNumberRow(["sin", "cos", "tan", "√"]),
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("0", () => _numClick("0"), Colors.black45),
                    _buildButton(".", clickDot, Colors.black45),
                    _buildButton("⌫", back, Colors.deepOrangeAccent.shade400),
                    _buildButton("=", equals, Colors.deepOrangeAccent.shade400),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, Color fillColor,
      [Color textColor = Colors.white, double width = 70.0]) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      shape: CircleBorder(),
      fillColor: fillColor,
      constraints: BoxConstraints.tight(Size(width, 70.0)),
    );
  }

  Widget _buildNumberRow(List<String> texts) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: texts.map((text) {
          if (operators.contains(text)) {
            return _buildButton(text, () => _operatorClick(text), Colors.white,
                Colors.deepOrangeAccent.shade400);
          } else if (text == "sin" ||
              text == "cos" ||
              text == "tan" ||
              text == "√") {
            return _buildButton(
                text,
                () => _scientificClick(text == "√" ? "sqrt" : text),
                Colors.black45);
          } else {
            return _buildButton(text, () => _numClick(text), Colors.black45);
          }
        }).toList(),
      ),
    );
  }
}

class LengthConverterDialog extends StatefulWidget {
  @override
  _LengthConverterDialogState createState() => _LengthConverterDialogState();
}

class _LengthConverterDialogState extends State<LengthConverterDialog> {
  final List<String> units = ["Meters", "Kilometers", "Miles"];
  String fromUnit = "Meters";
  String toUnit = "Kilometers";
  String input = "";
  String result = "";

  void convert() {
    double value = double.tryParse(input) ?? 0.0;
    double convertedValue;

    if (fromUnit == "Meters" && toUnit == "Kilometers") {
      convertedValue = value / 1000;
    } else if (fromUnit == "Meters" && toUnit == "Miles") {
      convertedValue = value * 0.000621371;
    } else if (fromUnit == "Kilometers" && toUnit == "Meters") {
      convertedValue = value * 1000;
    } else if (fromUnit == "Kilometers" && toUnit == "Miles") {
      convertedValue = value * 0.621371;
    } else if (fromUnit == "Miles" && toUnit == "Meters") {
      convertedValue = value / 0.000621371;
    } else if (fromUnit == "Miles" && toUnit == "Kilometers") {
      convertedValue = value / 0.621371;
    } else {
      convertedValue = value; // Same unit conversion
    }

    setState(() {
      result = convertedValue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Length Converter"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: (text) {
              setState(() {
                input = text;
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Input Value",
            ),
          ),
          DropdownButton<String>(
            value: fromUnit,
            onChanged: (String? newValue) {
              setState(() {
                fromUnit = newValue!;
              });
            },
            items: units.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: toUnit,
            onChanged: (String? newValue) {
              setState(() {
                toUnit = newValue!;
              });
            },
            items: units.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            child: Text("Convert"),
            onPressed: convert,
          ),
          Text(
            "Result: $result",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class WeightConverterDialog extends StatefulWidget {
  @override
  _WeightConverterDialogState createState() => _WeightConverterDialogState();
}

class _WeightConverterDialogState extends State<WeightConverterDialog> {
  final List<String> units = ["Grams", "Kilograms", "Pounds"];
  String fromUnit = "Grams";
  String toUnit = "Kilograms";
  String input = "";
  String result = "";

  void convert() {
    double value = double.tryParse(input) ?? 0.0;
    double convertedValue;

    if (fromUnit == "Grams" && toUnit == "Kilograms") {
      convertedValue = value / 1000;
    } else if (fromUnit == "Grams" && toUnit == "Pounds") {
      convertedValue = value * 0.00220462;
    } else if (fromUnit == "Kilograms" && toUnit == "Grams") {
      convertedValue = value * 1000;
    } else if (fromUnit == "Kilograms" && toUnit == "Pounds") {
      convertedValue = value * 2.20462;
    } else if (fromUnit == "Pounds" && toUnit == "Grams") {
      convertedValue = value / 0.00220462;
    } else if (fromUnit == "Pounds" && toUnit == "Kilograms") {
      convertedValue = value / 2.20462;
    } else {
      convertedValue = value; // Same unit conversion
    }

    setState(() {
      result = convertedValue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Weight Converter"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: (text) {
              setState(() {
                input = text;
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Input Value",
            ),
          ),
          DropdownButton<String>(
            value: fromUnit,
            onChanged: (String? newValue) {
              setState(() {
                fromUnit = newValue!;
              });
            },
            items: units.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: toUnit,
            onChanged: (String? newValue) {
              setState(() {
                toUnit = newValue!;
              });
            },
            items: units.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            child: Text("Convert"),
            onPressed: convert,
          ),
          Text(
            "Result: $result",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class GraphPlotterDialog extends StatefulWidget {
  @override
  _GraphPlotterDialogState createState() => _GraphPlotterDialogState();
}

class _GraphPlotterDialogState extends State<GraphPlotterDialog> {
  final TextEditingController _expressionController = TextEditingController();
  List<FlSpot> _spots = [];

  void _plotGraph() {
    String expression = _expressionController.text;
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();

    List<FlSpot> spots = [];
    for (double x = -10; x <= 10; x += 0.1) {
      cm.bindVariable(Variable('x'), Number(x));
      double y = exp.evaluate(EvaluationType.REAL, cm);
      spots.add(FlSpot(x, y));
    }

    setState(() {
      _spots = spots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Graph Plotter"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _expressionController,
            decoration: InputDecoration(
              labelText: "Enter expression (e.g., x^2)",
            ),
          ),
          ElevatedButton(
            child: Text("Plot"),
            onPressed: _plotGraph,
          ),
          SizedBox(
            height: 300,
            width: 300,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: _spots,
                    isCurved: false,
                    barWidth: 2,
                    colors: [Colors.deepOrangeAccent.shade400],
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(showTitles: true),
                  bottomTitles: SideTitles(showTitles: true),
                ),
                gridData: FlGridData(show: true),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void main() => runApp(CalculatorScreen());
