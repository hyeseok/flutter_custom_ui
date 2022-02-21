import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_ui/src/temperature_horizontal_bar.dart';
import 'package:flutter_custom_ui/src/temperature_vertical_bar.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  int? _currentIndex;
  int? _currentIndex2;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemperatureVerticalBar(10, _currentIndex ?? 1,
              showCountView: true,
            ),
            TemperatureHorizontalBar(10, _currentIndex2 ?? 1,
              gradientStartColor: Colors.blueAccent,
              gradientEndColor: Colors.yellowAccent,
              showCountView: true,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted) {
            setState(() {
              _currentIndex = Random().nextInt(11);
              _currentIndex2 = Random().nextInt(11);
            });
          }
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

}