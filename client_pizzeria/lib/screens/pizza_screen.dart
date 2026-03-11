import 'package:client_pizzeria/domain/entities/pizza.dart';
import 'package:client_pizzeria/repo_singleton.dart';
import 'package:client_pizzeria/screens/widgets/llista_pizzes.dart';
import 'package:client_pizzeria/screens/widgets/pizza_detail.dart';
import 'package:flutter/material.dart';

class PizzaScreen extends StatefulWidget {
  const PizzaScreen({super.key});

  @override
  State<PizzaScreen> createState() => _PizzaScreenState();
}

class _PizzaScreenState extends State<PizzaScreen> {
  Pizza? _pizzaSeleccionada;
  int _paginaActual = 1;
  final int _pageSize = 6;
  Future<List<Pizza>>? _llistaPizzes;

  // Sobreescrita funcion init state para que carge las pizzas al inicio
  @override
  initState() {
    super.initState();
    _cargarPizzas();
  }

  // Future a la API para recoger los datos
  _cargarPizzas() {
    _llistaPizzes = RepoSingleton().repo.getPizzes(
      pageNumber: _paginaActual,
      pageSize: _pageSize,
    );
  }

  // Guardar estado de la pizza seleccionada actual
  _seleccionarPizza(Pizza pizza) {
    setState(() {
      _pizzaSeleccionada = pizza;
    });
  }

  // Pasa a la anterior solo si no es menor a 1 y vuelve a cargar las pizzas
  _paginaAnterior() {
    if (_paginaActual > 1) {
      setState(() {
        _paginaActual--;
        _cargarPizzas();
      });
    }
  }

  // Pasa a la suigiente pagina y vuelve a cargar las pizzas
  _paginaSiguiente() {
    setState(() {
      _paginaActual++;
      _cargarPizzas();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Detecta si esta en vertical u horizontal
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: const Text('ElJust Eat Pizza')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child:
            isLandscape
                // Vertical
                ? Row(
                  children: [
                    Expanded(child: PizzaDetail(pizza: _pizzaSeleccionada)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FutureBuilder(
                        future: _llistaPizzes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return LlistaPizzes(
                              pizzes: snapshot.data ?? [],
                              onPizzaSelected: _seleccionarPizza,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                )
                // Horizontal
                : Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: PizzaDetail(pizza: _pizzaSeleccionada),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: FutureBuilder(
                        future: _llistaPizzes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return LlistaPizzes(
                              pizzes: snapshot.data ?? [],
                              onPizzaSelected: _seleccionarPizza,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: _paginaActual > 1 ? _paginaAnterior : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Anterior'),
            ),
            ElevatedButton.icon(
              onPressed: _paginaSiguiente,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Següent'),
            ),
          ],
        ),
      ),
    );
  }
}
