import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/beguda.dart';

class LlistaBegudes extends StatelessWidget {
  final List<Beguda> llistaBegudes;
  const LlistaBegudes(this.llistaBegudes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: llistaBegudes.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          nom: llistaBegudes[index].name,
          img: llistaBegudes[index].img ?? "",
          preu: llistaBegudes[index].price ?? 0.0,
          info: llistaBegudes[index].additionalInfo ?? "",
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final String nom;
  final String img;
  final double preu;
  final String info;

  const ListItem({
    super.key,
    required this.nom,
    required this.img,
    required this.preu,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    String prefix =
        "https://healthys-backend.globeapp.dev/"; // ;Millor obtenir-la de l'API

    return Card(
      child: Row(
        children: <Widget>[
          Image.network(
            img,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              width: 100,
              height: 100,
              child: FittedBox(child: Icon(Icons.question_mark)),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  nom,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(info),
                // Aci va el widget per ala alergens
                Text("No s'han descrit els alèrgens"),
              ],
            ),
          ),
          Text(
            '$preu€',
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
