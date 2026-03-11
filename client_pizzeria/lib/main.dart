import 'package:client_pizzeria/screens/pizza_screen.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

const seed = Colors.red; // Color llavor

void main() => runApp(AppPizzes());

class AppPizzes
    extends StatelessWidget {
  const AppPizzes({super.key});
  @override
  Widget build(BuildContext context) {
    // Fem ús de colors dinàmics si estan definits al sistema
    // DynamicColorBuilder ha d’envoltar el MaterialApp dins del builder
    return DynamicColorBuilder(
      builder: (
        ColorScheme? lightDyn,
        ColorScheme? darkDyn,
      ) {
        final ColorScheme light =
            (lightDyn?.harmonized()) ??
            ColorScheme.fromSeed(
              seedColor: seed,
              brightness:
                  Brightness.light,
            );

        final ColorScheme dark =
            (darkDyn?.harmonized()) ??
            ColorScheme.fromSeed(
              seedColor: seed,
              brightness:
                  Brightness.dark,
            );

        return MaterialApp(
          debugShowCheckedModeBanner:
              false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: dark,
          ),
          home: PizzaScreen(),
        );
      },
    );
  }
}
