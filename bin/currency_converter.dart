import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CurrencyConvertorStateBuilder extends StatefulWidget {
  const CurrencyConvertorStateBuilder({super.key});
  @override
  State createState() => _CurrencyConvertorState();
}

class _CurrencyConvertorState extends State<CurrencyConvertorStateBuilder> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    double result = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 33, 33, 33),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result.toString(),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 159, 243, 33),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: Color.fromARGB(255, 203, 205, 207),
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter amount in USD',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 159, 243, 33),
                  ),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: Color.fromARGB(255, 159, 243, 33),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 159, 243, 33),
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 33, 33, 33),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  print(textEditingController.text);
                  result = double.parse(textEditingController.text) * 83;
                  setState(() {});
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white10,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    color: Color.fromARGB(255, 159, 243, 33),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
