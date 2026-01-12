import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/beguda.dart';

class LlistaBegudesSimple extends StatelessWidget {
  final List<Beguda> llistaBegudes;
  const LlistaBegudesSimple(this.llistaBegudes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: llistaBegudes.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(llistaBegudes[index].toString());
      },
    );
  }
}

//class
