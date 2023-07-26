import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:kbtg_academy/widget/simple_text.dart';

void main() {
  testGoldens('Test Golden for Simple test', (tester) async {
    // final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
    //   ..addScenario('Sunny', MaterialApp(home: Scaffold(body: SimpleText())));
    // await tester.pumpWidgetBuilder(builder.build());
    await tester.pumpWidgetBuilder(SimpleText());

    await screenMatchesGolden(tester, 'simeple_text_golden');
  });
}
