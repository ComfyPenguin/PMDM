import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/producte.dart';

// Llista de prova dels productes (no s'usa)
class LlistaProductesSimple extends StatelessWidget {
  final List<Producte> llistaProductes;
  const LlistaProductesSimple(this.llistaProductes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: llistaProductes.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(llistaProductes[index].toString());
      },
    );
  }
}
