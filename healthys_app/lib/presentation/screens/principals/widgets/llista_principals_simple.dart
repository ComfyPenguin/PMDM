import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/principal.dart';

class LlistaPrincipalsSimple extends StatelessWidget {
  final List<Principal> llistaPrincipals;
  const LlistaPrincipalsSimple(this.llistaPrincipals, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: llistaPrincipals.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(llistaPrincipals[index].toString());
      },
    );
  }
}

//class
