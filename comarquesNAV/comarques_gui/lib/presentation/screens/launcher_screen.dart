import 'package:comarques_gui/presentation/screens/comarques_screen.dart';
import 'package:comarques_gui/presentation/screens/infocomarca_general.dart';
import 'package:comarques_gui/presentation/screens/provincies_screen.dart';
import 'package:flutter/material.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Les nostres comarques")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ProvinciesScreen(),
                  ),
                );
              },
              child: const Text("Pantalla Provincies"),
            ),
          ],
        ),
      ),
    );
  }
}
