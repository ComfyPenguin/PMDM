import 'package:client_pizzeria/domain/entities/pizza.dart';
import 'package:client_pizzeria/screens/widgets/pizza_item.dart';
import 'package:flutter/material.dart';

class LlistaPizzes extends StatelessWidget {
  const LlistaPizzes({super.key, this.pizzes, this.onPizzaSelected});

  final List<Pizza>? pizzes;
  final Function(Pizza)? onPizzaSelected;

  @override
  Widget build(BuildContext context) {
    if (pizzes != null) {
      return ListView.builder(
        itemCount: pizzes?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          // Creem un item de PizzaItem amb la pizza en qüestió
          // TO-DO: Caldrà veure si li passem alguna cosa més...
          return PizzaItem(pizza: pizzes?[index], onTap: onPizzaSelected);
        },
      );
    } else {
      return LinearProgressIndicator();
    }
  }
}
