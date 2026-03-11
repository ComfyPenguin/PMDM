import 'package:comarques_gui/presentation/screens/comarques_screen.dart';
import 'package:comarques_gui/repo_singleton.dart';
import 'package:comarques_gui/domain/entities/provincia.dart';
import 'package:flutter/material.dart';

class ProvinciesScreen extends StatelessWidget {
  ProvinciesScreen({super.key});

  // Accés al repositori a través del Singleton
  // Obtenim amb ell un Future amb la llista de províncies
  final Future<List<Provincia>?> _llistaProvinciesFuture = RepoSingleton().repo
      .obtenirProvincies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Províncies')),
      body: FutureBuilder<List<Provincia>?>(
        future: _llistaProvinciesFuture, // Future del que depenem
        builder: (context, asyncSnapshot) {
          // Quan el Future es complete, tindrem el resultat a l'snapshot
          // Segons el que aquest continga, dibuixarem uns widgets o altres

          // Barra de progrés circular mentre s'està carregant
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Si l'snapshot conté algun error el mostrem
          if (asyncSnapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "S'ha produït un error: ${asyncSnapshot.error}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Si arribem aci, veiem si l'snapshot conté dades.
          // (Si no en conté generem una llista buida)
          final llista = asyncSnapshot.data ?? const <Provincia>[];

          // Si la llista de províncies és buida (l'snapshot no conté dades) ho indiquem
          if (llista.isEmpty) {
            return const Center(child: Text("No s'han trobat províncies"));
          }

          // Si conté dades, generem les targetes
          return Padding(
            // Padding per deixar uun marge
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              // Generem la llista de widgets proporcionant-li la llista de províncies
              itemCount: llista.length,
              itemBuilder: (context, i) {
                final p = llista[i];
                return ProvinciaCard(
                  nom: p.nom,
                  img: p.imatge ?? '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComarquesScreen(nomProvincia: p.nom),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Widget per representar la targeta  (Card) amb la província
// Podriem definir-la en un fitxer a banda, dins la carpeta presentation/widgets
class ProvinciaCard extends StatelessWidget {
  final String nom;
  final String img;
  final VoidCallback? onTap; 
  
  const ProvinciaCard({
    super.key, 
    required this.nom, 
    required this.img ,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
      // Xicoteta elevació per l'efecte de profunditat
      elevation: 4,
      // Amb shape li donem forma, en aquest cas, fem les vores arrodonides
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ), // definim el radi per a les vores
      ),
      clipBehavior:
          Clip.antiAlias, // Amb això evitem que les imatges se n'isquen
      child: Container(
        height: 150, // Fem un contenidor d'alçada fixa
        padding: const EdgeInsets.all(16),
        // Afegim la imatge dins la propietat decoration de la targeta
        decoration: BoxDecoration(
          // Afegim un color de fons des del tema si no hi ha imatge
          color: Theme.of(context).disabledColor,
          // Afegim la imatge perquè ocupe tot l'espai
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
        ),
        child: Align(
          // Text a la part inferior esquerra
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              nom,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Color del text
                fontFamily: 'Roboto', // Tipografia
                // Ombra per al text
                shadows: const [
                  Shadow(
                    blurRadius: 6.0,
                    color: Colors.black45,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
    );
  }
}
