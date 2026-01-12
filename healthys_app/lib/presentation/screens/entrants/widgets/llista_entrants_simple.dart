import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/entrant.dart';

class LlistaEntrantsSimple extends StatelessWidget {
  final List<Entrant> llistaEntrants;
  const LlistaEntrantsSimple(this.llistaEntrants, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: llistaEntrants.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(llistaEntrants[index].toString());
      },
    );
  }
}

//class
