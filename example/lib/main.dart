import 'package:flutter/material.dart';
import 'package:simple_charts/simple_charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charts Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Simple charts Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final data1 = {
    DateTime.now(): 10,
    DateTime.now().add(const Duration(days: 1)): 23,
    DateTime.now().add(const Duration(days: 2)): 5,
    DateTime.now().add(const Duration(days: 3)): 15,
    DateTime.now().add(const Duration(days: 4)): 20,
    DateTime.now().add(const Duration(days: 5)): 50,
  };

  final data2 = {
    'Data 1': 0,
    'Data 2': 1,
    'Data 3': 2,
    'Data 4': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Example of date chart :'),
            const SizedBox(
              height: 24,
            ),
            DateChart(data: data1),
            const SizedBox(
              height: 52,
            ),
            const Text('Example of percentage chart :'),
            const SizedBox(
              height: 24,
            ),
            PercentageChart(data: data2)
          ],
        ),
      ),
    );
  }
}
