import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFakeAsync = true;
  bool isCalcRunning = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            isFakeAsync //
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
          ),
          onPressed: () {
            setState(() {
              isFakeAsync = !isFakeAsync;
            });
          },
        ),
        body: isCalcRunning
            ? const CircularProgressIndicator()
            : FloatingActionButton(
                child: const Icon(Icons.calculate),
                onPressed: () async {
                  setState(() {
                    isCalcRunning = true;
                  });
                  // give time to at least show circular if not fakeAsync
                  await Future.delayed(const Duration(milliseconds: 10));
                  await longCalc();
                  setState(() {
                    isCalcRunning = false;
                  });
                },
              ),
      ),
    );
  }

  Future<void> longCalc() async {
    final t0 = DateTime.now();
    for (int i = 0; i < 10000; i++) {
      for (int j = 0; j < 10000; j++) {
        final calc = i + j;
        bool isDividableBy10000 = (calc % 10000) == 0;
        if (isDividableBy10000) {
          if (isFakeAsync) {
            await Future.delayed(const Duration(microseconds: 1));
          }
        }
      }
    }
    print("done in ${DateTime.now().difference(t0)}");
  }
}
