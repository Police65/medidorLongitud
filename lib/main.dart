import 'package:flutter/material.dart';
import 'utils/conversion_helper.dart';

void main() => runApp(ConversionApp());

class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unidad de conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConversionPage(),
    );
  }
}

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  String _inputValue = "";
  bool _isDarkMode = false;
  String _result = "";
  String _startUnit = "Metros";
  String _convertedUnit = "Centimetros";

  void _convert() {
    setState(() {
      double inputValue = double.tryParse(_inputValue) ?? 0.0;
      double meters = 0.0;

      switch (_startUnit) {
        case 'Metros':
          meters = inputValue;
          break;
        case 'Centimetros':
          meters = ConversionHelper.centimetersToMeters(inputValue);
          break;
        case 'Pies':
          meters = ConversionHelper.feetToMeters(inputValue);
          break;
        case 'Pulgadas':
          meters = ConversionHelper.inchesToMeters(inputValue);
          break;
      }

      switch (_convertedUnit) {
        case 'Metros':
          _result = '$meters m';
          break;
        case 'Centimetros':
          _result = '${ConversionHelper.metersToCentimeters(meters)} cm';
          break;
        case 'Pies':
          _result = '${ConversionHelper.metersToFeet(meters)} ft';
          break;
        case 'Pulgadas':
          _result = '${ConversionHelper.metersToInches(meters)} in';
          break;
      }
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _appendDigit(String digit) {
    setState(() {
      _inputValue += digit;
    });
  }

  void _deleteDigit() {
    setState(() {
      _inputValue = _inputValue.isNotEmpty
          ? _inputValue.substring(0, _inputValue.length - 1)
          : "";
    });
  }

  void _clearAll() {
    setState(() {
      _inputValue = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Unidad de conversion'),
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(_isDarkMode ? Icons.brightness_7 : Icons.brightness_3),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    _inputValue,
                    style: TextStyle(
                      fontSize: 24,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _convert,
                    child: Text('Convertir'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _result,
                    style: TextStyle(
                      fontSize: 24,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _startUnit,
                    style: TextStyle(
                        color: _isDarkMode ? Colors.white : Colors.black),
                    items: <String>['Metros', 'Centimetros', 'Pies', 'Pulgadas']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _startUnit = newValue ?? _startUnit;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: _convertedUnit,
                    style: TextStyle(
                        color: _isDarkMode ? Colors.white : Colors.black),
                    items: <String>['Metros', 'Centimetros', 'Pies', 'Pulgadas']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _convertedUnit = newValue ?? _convertedUnit;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('C'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('x'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('='),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton('0'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String digit) {
    return ElevatedButton(
      onPressed: () {
        if (digit == 'C') {
          _clearAll();
          //Si antes de las 12 de la noche encuentro los iconos le pongo los iconos y no esos caracteres
        } else if (digit == 'x') {
          _deleteDigit();
        } else if (digit == '=') {
          _convert();

          //Estoy entregando la tarea con datos moviles pq hay una falla masiva en PSN

          //Tardara en suvirse el malparido comit, pipipi
        } else {
          _appendDigit(digit);
        }
      },
      child: Text(digit),
    );
  }
}
