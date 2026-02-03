import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/producte.dart';
import 'package:healthys_app/presentation/screens/productes/producte_screen.dart';
import 'package:healthys_app/presentation/widgets/carret_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    // Scaffold que engloba totes les viste. Més senzill que mantenir un
    // scaffold per cada vista.
    // Canviem només el body.
    return Scaffold(
      //appBar: AppBar(title: const Text("Healthys App")),
      appBar: AppBar(
        title: Image(
          image: AssetImage("assets/img/healthys_logo.png"),
          height: 100,
        ),
        // Afegim al final de l'Appbar un widget amb la quantitat
        // de productes que té el carret. Quan es faça clic en ell
        // obrirem una vista amb el contingut
        actions: [CarretWidget()],
      ),

      // IndexedStack és el que es recomana per mantenir
      // l'estat de les vistes en aquests esquemes.
      body: IndexedStack(
        index: paginaActual,
        children: [
          ProducteScreen(tipus: ProductsType.entrant),
          ProducteScreen(tipus: ProductsType.principal),
          ProducteScreen(tipus: ProductsType.beguda),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            paginaActual = index;
          });
        },
        // Per a les icones, podem consultar el catàleg
        // de Material en https://fonts.google.com/icons
        selectedIndex: paginaActual,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.bento_outlined),
            selectedIcon: Icon(Icons.bento),
            label: 'Entrants',
          ),
          NavigationDestination(
            icon: Icon(Icons.rice_bowl_outlined),
            selectedIcon: Icon(Icons.rice_bowl),
            label: 'Principals',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_bar_outlined),
            selectedIcon: Icon(Icons.sports_bar),
            label: 'Begudes',
          ),
        ],
      ),
    );
  }
}
