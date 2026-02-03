import 'package:flutter/material.dart';

//Widget auxiliar per als botons de l'Appbar simulat. Li passem
// la icona i una funció de callback a executar quan es fa clic

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    //final cs = Theme.of(context).colorScheme;
    // Widget nou! Defineix un component Material (hereta les propeitats
    // de disseny de Material). En el nostre cas tindrà un detector de
    // gestos de tipus Inkwell de forma circular
    return Material(
      color: Colors.black.withValues(alpha: 0.28),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
