// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberCount = 0;

  void increment() {
    setState(() {
      numberCount++;
    });
    saveData();
  }

  void decrement() {
    setState(() {
      numberCount--;
    });
    saveData();
  }

  void saveData() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('counter') != null) {
      prefs.remove('counter');
    }

    await prefs.setInt('counter', numberCount);

    print(prefs.getInt('counter'));
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      numberCount = prefs.getInt("counter") ?? 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preft App"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                decrement();
              },
              child: Text("-"),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                numberCount.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                increment();
              },
              child: Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}
