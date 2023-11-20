import 'package:flutter/material.dart';

class TempPage extends StatefulWidget {
  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  double inputValue = 0;
  String selectedInputUnit = 'Цельсия(°C)';
  String selectedOutputUnit = 'Фаренгейта(°F)';
  bool showResult = false;

  final Map<String, String> unitFactors = {
    'Цельсия(°C)': '',
    'Фаренгейта(°F)': '',
    'Кельвины(K)': '',
  };

  double convertedValue() {
    double inputTemperature = inputValue;
    double outputTemperature;
    if (inputValue == 0 || !showResult) {
      return 0;
    }
    if (selectedInputUnit == 'Цельсия(°C)' && selectedOutputUnit == 'Фаренгейта(°F)') {
      outputTemperature = (inputTemperature * 9/5) + 32;
    } else if (selectedInputUnit == 'Фаренгейта(°F)' && selectedOutputUnit == 'Цельсия(°C)') {
      outputTemperature = (inputTemperature - 32) * 5/9;
    } else if (selectedInputUnit == 'Цельсия(°C)' && selectedOutputUnit == 'Кельвины(K)') {
      outputTemperature = inputTemperature + 273.15;
    } else if (selectedInputUnit == 'Кельвины(K)' && selectedOutputUnit == 'Цельсия(°C)') {
      outputTemperature = inputTemperature - 273.15;
    } else if (selectedInputUnit == 'Фаренгейта(°F)' && selectedOutputUnit == 'Кельвины(K)') {
      outputTemperature = (inputTemperature - 32) * 5/9 + 273.15;
    } else if (selectedInputUnit == 'Кельвины(K)' && selectedOutputUnit == 'Фаренгейта(°F)') {
      outputTemperature = (inputTemperature - 273.15) * 9/5 + 32;
    } else {

      outputTemperature = inputTemperature;
    }

    return outputTemperature;
  }

  void swapUnits() {
    setState(() {
      String temp = selectedInputUnit;
      selectedInputUnit = selectedOutputUnit;
      selectedOutputUnit = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Конвертер температур', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Color(0xFF00FFFF), fontSize: 25),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  showResult = true;
                  inputValue = double.tryParse(value) ?? 0;
                });
              },
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                hintText: 'Введите число',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDropdownButton(selectedInputUnit, (String? newValue) {
                  setState(() {
                    selectedInputUnit = newValue!;
                  });
                }),
                IconButton(
                  icon: Icon(Icons.swap_horiz, color: Color(0xFF00FFFF)),
                  onPressed: swapUnits,
                ),
                buildDropdownButton(selectedOutputUnit, (String? newValue) {
                  setState(() {
                    selectedOutputUnit = newValue!;
                  });
                }),
              ],
            ),
            SizedBox(height: 40),
            buildRichText(),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton(String value, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      style: TextStyle(color: Colors.white),
      dropdownColor: Colors.black,
      value: value,
      onChanged: onChanged,
      items: unitFactors.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(
        text: 'Преобразованное значение: ',
        style: TextStyle(fontSize: 18, color: Colors.white),
        children: [
          TextSpan(
            text: FormattedValue(convertedValue().toStringAsFixed(5)),
            style: TextStyle(fontSize: 18, color: Color(0xFF00FFFF)),
          )
        ],
      ),
    );
  }
  String FormattedValue(String value) {
    return value.contains('.')
        ? value.replaceAll(RegExp(r"0*$"), "").replaceAll(RegExp(r"\.$"), "")
        : value;
  }
}
