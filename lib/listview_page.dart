// Create a listview page with bottom tabbar
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kbtg_academy/details_page.dart';
import 'package:kbtg_academy/home_page.dart';
import 'package:kbtg_academy/pokemon.dart';
import 'package:kbtg_academy/pokemon.dart';
import 'package:kbtg_academy/bloc/pokemon_bloc.dart';
import 'package:kbtg_academy/routing_path.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = [];
  final bloc = PokemonBloc();
  static const platform = MethodChannel('com.kbtg.academy');
  String? batteryLevel;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      _pokemonListView(),
      const Text('page 1'),
      Text('Battery Level $batteryLevel'),
      Container(color: Colors.red),
      const MyHomePage()
    ];

    try {
      bloc.fetchPokemonList();
    } catch (e) {
      print("==== noooo ${e.toString()}");
    }

    _getBatteryLevel();
    _getInt();
  }

  Future<void> _getBatteryLevel() async {
    if (Platform.isIOS || Platform.isAndroid) {
      try {
        final int result = await platform.invokeMethod('getBatteryLevel');
        batteryLevel = 'Battery level at $result % .';
      } on PlatformException catch (e) {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      }
    }
  }

  Future<void> _getInt() async {
    if (Platform.isIOS) {
      try {
        final int result = await platform.invokeMethod('getInt');
        print("==== get result $result");
      } on PlatformException catch (e) {
        print(e.message);
      }
    }
  }

  Widget _pokemonListView() {
    return Column(
      children: [
        SearchBar(onChanged: (value) {
          bloc.searchPokemon(value);
        }),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: bloc.pokemonNameList,
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      print("=tap completed at $index ${value[index]}");
                      context.go(
                          "${RoutePath.details.path}/${value[index]}/$index");
                    },
                    leading: CircleAvatar(
                      child: Image.network('https://picsum.photos/250?image=9'),
                      radius: 8,
                    ),
                    title: Text(value[index]),
                    subtitle: Text("hello"),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(Object context) {
    print("==== ListView page rebuild ====");
    return Scaffold(
      appBar: AppBar(
        title:
            const Align(alignment: Alignment.centerLeft, child: Text('Team')),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon_sharp),
            label: 'Pokemon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Floor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Directory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_rounded),
            label: 'About us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.zoom_in),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
