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
  double _inputValue = 0.0;
  bool _isDarkMode = false;
  String _result = "";
  String _startUnit = "Metros";
  String _convertedUnit = "Centimetros";

  void _convert() {
    setState(() {
      double meters = 0.0;

      switch (_startUnit) {
        case 'Metros':
          meters = _inputValue;
          break;
        case 'Centimetros':
          meters = ConversionHelper.centimetersToMeters(_inputValue);
          break;
        case 'Pies':
          meters = ConversionHelper.feetToMeters(_inputValue);
          break;
        case 'Pulgadas':
          meters = ConversionHelper.inchesToMeters(_inputValue);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: _isDarkMode ? Color(0xFF202225) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isDarkMode ? Color(0xFF37393f) : Color(0xFF37393f),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                value: _startUnit,
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
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
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
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
              TextField(
                onChanged: (value) {
                  setState(() {
                    _inputValue = double.tryParse(value) ?? 0.0;
                  });
                },
                style:
                    TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingresa el valor en $_startUnit',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black),
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
            ],
          ),
        ),
      ),
    );
  }
}
