import 'package:flutter/material.dart';
import 'utils/conversion_helper.dart';

void main() => runApp(ConversionApp());

class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Conversion',
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

  void _convert() {
    setState(() {
      _result =
          "Centimetros: ${ConversionHelper.metersToCentimeters(_inputValue)}\n"
          "pies: ${ConversionHelper.metersToFeet(_inputValue)}\n"
          "pulgadas: ${ConversionHelper.metersToInches(_inputValue)}";
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
        actions: <Widget>[
          IconButton(
            icon: Icon(_isDarkMode ? Icons.brightness_7 : Icons.brightness_3),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0.0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introduce el valor en metros',
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
    );
  }
}
