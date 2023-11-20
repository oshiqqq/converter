import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  double inputValue = 0;
  String selectedInputUnit = 'Рубли';
  String selectedOutputUnit = 'Доллары';

  final Map<String, double> unitFactors = {
    'Рубли': 1,
    'Доллары': 0.01119,
    'Евро': 0.01026,
    'Тенге': 5.26315,
  };

  double convertedValue() {
    double factor = unitFactors[selectedOutputUnit]! / unitFactors[selectedInputUnit]!;
    return inputValue * factor;
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
        title: Text('Конвертер валют', style: TextStyle(color: Colors.white)),
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
