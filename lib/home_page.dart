import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:kbtg_academy/routing_path.dart';
import 'package:kbtg_academy/widget/simple_checkbox.dart';
import 'package:kbtg_academy/widget/simple_text.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  List<Widget> _topSection(ThemeData theme) {
    return [
      const SizedBox(height: 40),
      Center(child: Text('Sign up', style: theme.textTheme.displayLarge)),
      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account?', style: theme.textTheme.titleSmall),
          TextButton(
              onPressed: () {
                print("===== hello sign in ----");
                throw Exception();
              },
              child: Text('Sign in',
                  style: TextStyle(color: Colors.blueAccent.shade400)))
        ],
      ),
    ];
  }

  List<Widget> _formSection() {
    return [
      TextField(
        maxLength: 50,
        onChanged: (char) {
          _counter.value = char.length;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Please input only your company email'),
      ),
      const SizedBox(height: 25),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
        ),
      ),
      const SizedBox(height: 25),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
        ),
      ),
      const SizedBox(height: 25),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
        ),
      ),
    ];
  }

  bool isChecked = false;

  Widget _termAndConditionSection(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleCheckbox(onChanged: (value) {
          FirebaseAnalytics.instance.logEvent(name: "checkbox", parameters: {
            "value": value,
          });
          controller.sink.add(value);
        }),
        const SimpleText(),
        TextButton(
            onPressed: () {
              print("===== hello sign in ----");
              FirebaseAnalytics.instance.logEvent(name: "terms_and_conditions");
            },
            child: const Text('Terms and Conditions',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)))
      ],
    );
  }

  final stop = Stopwatch();

  @override
  void initState() {
    super.initState();
    stop.start();
  }

  Future<void> printValue() async {
    print("===== 1 ${stop.elapsedMilliseconds} =====");
    Future.delayed(Duration(milliseconds: 500), () {
      print("===== init state 5 =====");
    });
    print("===== 2 ${stop.elapsedMilliseconds} =====");
    Future.delayed(Duration(milliseconds: 200), () {
      print("===== init state 1 =====");
    });
    print("===== 3 ${stop.elapsedMilliseconds} =====");
    Future.delayed(Duration(milliseconds: 100), () {
      print("===== init state 2 =====");
    });
    print("===== 4 ${stop.elapsedMilliseconds} =====");

    Future.delayed(Duration(milliseconds: 500), () {
      print("===== init state 3 =====");
    });

    Future.delayed(Duration(milliseconds: 200), () {
      print("===== init state 4 =====");
    });
    print("===== 5 ${stop.elapsedMilliseconds} =====");
  }

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final StreamController<bool> controller = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    print("====== Rebuild ======");
    final theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ..._topSection(theme),
              Align(
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget? child) {
                      return Text('$value/50');
                    },
                    valueListenable: _counter,
                    child: const Text('0/10'),
                  )),
              ..._formSection(),
              _termAndConditionSection(theme),
              StreamBuilder<bool>(
                  stream: controller.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    } else if (snapshot.hasData) {
                      final isChecked = snapshot.data ?? false;
                      return SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                )),
                                backgroundColor: MaterialStatePropertyAll(
                                    isChecked ? Colors.blue : Colors.grey),
                              ),
                              onPressed: () async {
                                if (isChecked) {
                                  context.go(RoutePath.listView.path);
                                } else {
                                  print("still disable na");
                                }
                              },
                              child: const Text('Sign up',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))));
                    } else {
                      print(
                          "==== rebuild state ${snapshot.connectionState.name} ====");

                      return SpinKitFadingCircle(
                          itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      });
                    }
                  }),
              const SizedBox(height: 20)
            ],
          )),
    )));
  }
}
