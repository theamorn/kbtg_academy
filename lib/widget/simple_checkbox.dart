// Create simeple Checkbox
import 'package:flutter/material.dart';

class SimpleCheckbox extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  const SimpleCheckbox({Key? key, this.onChanged}) : super(key: key);

  @override
  _SimpleCheckboxState createState() => _SimpleCheckboxState();
}

class _SimpleCheckboxState extends State<SimpleCheckbox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    print("=== Simple checkbox rebuild ====");
    final ThemeData theme = Theme.of(context);
    return Checkbox(
      value: _value,
      onChanged: (bool? value) {
        widget.onChanged?.call(value!);
        setState(() {
          _value = value!;
        });
      },
      side: const BorderSide(color: Colors.black),
      fillColor: MaterialStateProperty.resolveWith(getColor),
      checkColor: Colors.black,
    );
  }

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
}
