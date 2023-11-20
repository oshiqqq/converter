import 'package:flutter/material.dart';
import 'package:converter/pages/weight.dart';
import 'package:converter/pages/currency.dart';
import 'package:converter/pages/length.dart';
import 'package:converter/pages/square.dart';
import 'package:converter/pages/temperature.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мой Flutter App',
      theme: ThemeData.dark(
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/pages/weight.dart': (context) => WeightPage(),
        '/pages/currency': (context) => CurrencyPage(),
        '/pages/temperature': (context) => TempPage(),
        '/pages/length': (context) => LengthPage(),
        '/pages/square': (context) => SquarePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Главная страница'),
        backgroundColor: Colors.black,
    ),
    body: SingleChildScrollView(
    child: Center(
    child: Wrap(
    alignment: WrapAlignment.spaceAround,
    children: [
            IconCard(
              title: 'Вес/Масса',
              icon: Icons.accessibility,
              route: '/pages/weight.dart',
            ),
            IconCard(
              title: 'Валюта',
              icon: Icons.attach_money,
              route: '/pages/currency',
            ),
            IconCard(
              title: 'Температура',
              icon: Icons.ac_unit,
              route: '/pages/temperature',
            ),
            IconCard(
              title: 'Длина',
              icon: Icons.straighten,
              route: '/pages/length',
            ),
            IconCard(
              title: 'Площадь',
              icon: Icons.square_foot,
              route: '/pages/square',
            ),
          ],
    ),
    ),
    ),
      backgroundColor: Colors.black,
    );
  }
}

class IconCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  IconCard({required this.title, required this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 125,
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 50,
                color: Color(0xFF00FFFF),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
