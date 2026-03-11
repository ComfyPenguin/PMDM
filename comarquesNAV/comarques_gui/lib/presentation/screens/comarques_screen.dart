import 'package:comarques_gui/domain/entities/comarca_simple.dart';
import 'package:comarques_gui/presentation/screens/infocomarca_general.dart';
import 'package:comarques_gui/repo_singleton.dart';
import 'package:flutter/material.dart';

class ComarquesScreen extends StatelessWidget {
  final String nomProvincia;
  
  const ComarquesScreen({super.key, required this.nomProvincia});

  @override
  Widget build(BuildContext context) {
    // Carreguem les comarques utilitzant nomProvincia
    final comarquesFuture = RepoSingleton().repo.getComarques(nomProvincia);
    
    return Scaffold(
      appBar: AppBar(title: Text("Comarques de $nomProvincia")),
      body: FutureBuilder<List<ComarcaSimple>?>(
        future: comarquesFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

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

          final llista = asyncSnapshot.data ?? const <ComarcaSimple>[];

          if (llista.isEmpty) {
            return const Center(child: Text("No s'han trobat comarques"));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: llista.length,
              itemBuilder: (context, i) {
                final c = llista[i];
                return ComarcaCard(
                  nom: c.comarca,
                  img: c.img ?? '',
                  onTap: () {
                    // Navegar a la pantalla inforcomarca
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                         builder: (context) => InfoComarcaGeneral(nomComarca: c.comarca),
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

class ComarcaCard extends StatelessWidget {
  final String nom;
  final String img;
  final VoidCallback? onTap;

  const ComarcaCard({
    super.key,
    required this.nom,
    required this.img,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                nom,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Roboto',
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
      ),
    );
  }
}