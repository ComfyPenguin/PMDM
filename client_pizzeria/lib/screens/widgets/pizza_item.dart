import 'package:client_pizzeria/domain/entities/pizza.dart';
import 'package:client_pizzeria/screens/widgets/llista_alergens.dart';
import 'package:flutter/material.dart';

class PizzaItem extends StatelessWidget {
  final Pizza? pizza;
  final Function(Pizza)? onTap;

  const PizzaItem({this.pizza, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    String prefix = "https://pizza-rest-server-production.up.railway.app";

    return GestureDetector(
      onTap: () {
        if (pizza != null && onTap != null) {
          onTap!(pizza!);
        }
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Image.network(
              "$prefix${pizza?.img ?? ''}",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const SizedBox(
                    width: 100,
                    height: 100,
                    child: FittedBox(child: Icon(Icons.local_pizza_outlined)),
                  ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    pizza?.nom ?? "",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text('${pizza?.desc}'),
                  // Widget per als alèrgens
                  LlistaAlergens(alergens: pizza?.alergens),
                ],
              ),
            ),
            Text(
              '${pizza?.preu}€',
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
