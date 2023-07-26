import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  const SimpleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("=== Simple text rebuild ====");
    // final ThemeData theme = Theme.of(context);
    return Text(
      'I agree to the',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }
}
