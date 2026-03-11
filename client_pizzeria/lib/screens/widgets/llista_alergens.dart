import 'package:flutter/material.dart';

class LlistaAlergens extends StatelessWidget {
  const LlistaAlergens({super.key, this.alergens});

  final List<String>? alergens;

  @override
  Widget build(BuildContext context) {
    if (alergens == null || alergens!.isEmpty) {
      return const Text("No s'han descrit els alèrgens");
    }

    // recorre la lista de alergenos y devuelve una fila de estos
    return Row(
      children: [
        for (final alergen in alergens!)
          SizedBox(
            width: 32,
            height: 32,
            child: Image.asset('assets/img/$alergen.png'),
          ),
      ],
    );
  }
}
