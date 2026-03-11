// lib/screens/pizza_list_screen.dart

import 'package:client_pizzeria/domain/entities/pizza.dart';
import 'package:flutter/material.dart';

class PizzaDetail extends StatelessWidget {
  const PizzaDetail({super.key, required this.pizza});

  final Pizza? pizza;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child:
            pizza == null
                ? Image.asset("assets/img/eljust-pizza.png")
                : Column(
                  children: [
                    Text(
                      pizza?.desc ?? 'Sense descripció',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Image.network(
                      "https://pizza-rest-server-production.up.railway.app${pizza!.img}",
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.local_pizza_outlined, size: 100),
                    ),
                  ],
                ),
      ),
      //  ),
    );
  }
}
