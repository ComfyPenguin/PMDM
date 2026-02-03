import 'package:flutter/material.dart';

class CarretWidget extends StatelessWidget {
  const CarretWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        // El widget Chip fa com un requadre al voltant del contingut
        // Aci caldrà modificar el Text("0") per a que estiga "pendent"
        // de la quantitat d'elements del carret
        label: const Row(children: [Icon(Icons.shopping_cart), Text("0")]),
      ),
    );
  }
}
