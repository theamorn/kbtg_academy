// Create a pokemon details page with statefulwidget
import 'package:flutter/material.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage(
      {Key? key, required this.pokemonName, required this.age})
      : super(key: key);

  final String pokemonName;
  final String age;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    print("==== Pokemon details page rebuild ====");
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerLeft, child: Text(widget.pokemonName)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${widget.pokemonName} - with age ${widget.age}"),
            const SizedBox(height: 20),
            Text(
              'I agree to the',
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Checkbox(
              value: _value,
              onChanged: (bool? value) {
                setState(() {
                  _value = value!;
                });
              },
              side: const BorderSide(color: Colors.black),
              fillColor: MaterialStateProperty.resolveWith(getColor),
              checkColor: Colors.black,
            ),
          ],
        ),
      ),
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
