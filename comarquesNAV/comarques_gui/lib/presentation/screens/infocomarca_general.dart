// ignore_for_file: deprecated_member_use

import 'package:comarques_gui/repo_singleton.dart';
import 'package:comarques_gui/domain/entities/comarca.dart';
import 'package:flutter/material.dart';

class InfoComarcaGeneral extends StatelessWidget {

  final String nomComarca;

  const InfoComarcaGeneral({super.key, required this.nomComarca});
  
  //TO-DO
  // Accés al repositori a través del Singleton
  // Obtenim amb ell un Future amb la comarca (cal especifica explícitament!)
  // Compte que ara el Future no es resol a una llista, sinò a una comarca



  @override
  Widget build(BuildContext context) {
    final  comarcaFuture = RepoSingleton().repo.infoComarca(nomComarca);
    // TO-DO:
    // Crear els diferents widgets per tal de mostrar la informació sobre la comarca
    return Scaffold(
      appBar: AppBar(title: Text(nomComarca)),
      body: FutureBuilder<Comarca?>(
        future: comarcaFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            // Barra de progrés circular mentre s'està carregant
            return const Center(child: CircularProgressIndicator());
          }

          // Si l'snapshot conté algun error
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

          // Si no conté dades ho indiquem
          if (!asyncSnapshot.hasData) {
            return const Center(child: Text("No s'han trobat comarques"));
          }

          final comarca = asyncSnapshot.data;

          // TO-DO:
          // Si conté dades, generem la llista de targetes
          // Segurament haureu de generar un widget personalitzat per a les targetes
          return Padding(
            // Padding per deixar uun marge
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              // Generem la llista de widgets proporcionant-li la llista de províncies
              itemCount: 1,
              itemBuilder: (context, i) {
                final c = comarca;
                return ComarcaSimpleCard(
                  comarca: c?.comarca ?? '',
                  img: c?.img ?? '',
                  poblacio: c?.poblacio ?? '',
                  desc: c?.desc ?? '',
                  capital: c?.capital ?? '',
                  latitud: c?.latitud ?? 0.0,
                  longitud: c?.longitud ?? 0.0,
                );
              },
            ),
          );
        },
      ), ////
    );
  }
}

class ComarcaSimpleCard extends StatefulWidget {
  final String comarca;
  final String img;
  final String poblacio;
  final String desc;
  final String capital;
  final double latitud;
  final double longitud;

  const ComarcaSimpleCard({
    super.key,
    required this.comarca,
    required this.img,
    required this.poblacio,
    required this.desc,
    required this.capital,
    required this.latitud,
    required this.longitud,
  });

  @override
  State<ComarcaSimpleCard> createState() => _ComarcaSimpleCardState();
}

class _ComarcaSimpleCardState extends State<ComarcaSimpleCard>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: _hovering ? 4 : 2,
          clipBehavior: Clip.antiAlias,
          color: Colors.grey[100],
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  widget.img,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Content section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.comarca,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Capital
                    Text(
                      "Capital: ${widget.capital}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Description
                    Text(
                      widget.desc,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    
                    // Section title
                    Text(
                      "Demografia i ubicació",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Population
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            "Població:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        Text(
                          widget.poblacio,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    
                    // Latitude
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            "Latitud:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        Text(
                          widget.latitud.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    
                    // Longitude
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            "Longitud:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        Text(
                          widget.longitud.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}