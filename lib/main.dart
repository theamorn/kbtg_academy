import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kbtg_academy/home_page.dart';
import 'package:kbtg_academy/listview_page.dart';
import 'package:kbtg_academy/routing_path.dart';

import 'details_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: RoutePath.home.path,
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
    ),
    GoRoute(
      path: RoutePath.listView.path,
      builder: (BuildContext context, GoRouterState state) {
        return const ListViewPage();
      },
    ),
    GoRoute(
      path: "${RoutePath.details.path}/:name/:age",
      builder: (BuildContext context, GoRouterState state) {
        final pokemonName = state.pathParameters['name'] ?? 'Unknown';
        final age = state.pathParameters['age'] ?? "-";

        // final pokemonName =
        //     (state.extra as Map<String, dynamic>)['name'] ?? 'Unknown';
        // final age = (state.extra as Map<String, dynamic>)['age'] ?? 0;

        return PokemonDetailsPage(
          pokemonName: pokemonName,
          age: age,
        );
      },
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            )),
        useMaterial3: true,
      ),
    );
  }
}
