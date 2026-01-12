import 'package:flutter/material.dart';
import 'package:healthys_app/core/service_locator.dart';
import 'package:healthys_app/domain/entities/entrant.dart';

import 'package:healthys_app/presentation/screens/entrants/entrant_detall.dart';

class GridEntrants extends StatelessWidget {
  final List<Entrant> llistaEntrants;
  const GridEntrants(this.llistaEntrants, {super.key});

  // Funciona auxiliars per determinar propietats del grid i l'espaiat
  // segons les dimensions del dispositiu

  /// Calcula el nombre de columnes segons l'ample disponible
  int _getCrossAxisCount(double width) {
    // Desktop gran (si l'ample és més de 1200 px, fem 4 columnes)
    if (width >= 1200) return 4;
    // Desktop / Tablet en horitzontal (entre 900px i 1200px, 3 columnes)
    if (width >= 900) return 3;
    // Resta de casos (tablets verticals, mòbils..., menys de 900px: 2 col)
    return 2;
  }

  /// Calcula l'espaiat segons l'ample disponible
  double _getSpacing(double width) {
    // Pantalles grans (més de 1200 d'ample: 24px d'espaiat)
    if (width >= 1200) return 24.0;
    // Pantalles mitjanes (entre 900 i 1200 d'ample: 20px d'espaiat)
    if (width >= 900) return 20.0;
    // Tauletes en vertical (entre 600 i 900 px: 16 px d'espaiat)
    if (width >= 600) return 16.0;
    // Mòbils: Menys de 600 px: 12px d'espaiat
    return 12.0;
  }

  /// Calcula el padding horitzontal segons l'ample
  double _getHorizontalPadding(double width) {
    // Pantalles grans: 48 px
    if (width >= 1200) return 48.0;
    // Pantalles mitjanes: 32 px
    if (width >= 900) return 32.0;
    // Pantalles menudes: 24 px
    if (width >= 600) return 24.0;
    // Mòbils: 16 px
    return 16.0;
  }

  @override
  Widget build(BuildContext context) {
    // Fem ús del LayoutBuilder per obtindre la informació de la pantalla
    // Amb constrants.width sabem l'ample de la pantalla, i segons aixó
    // determinem les propietats

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = _getCrossAxisCount(width);
        final spacing = _getSpacing(width);
        final horizontalPadding = _getHorizontalPadding(width);

        // Giny GridView: NOU! Semblant a un ListView, però en forma de Grid
        // El builder funciona pràcticament igual:
        // - tenim un itemCount on dir-li el nombre d'items de la col·lecció,
        // - Tenim un itemBuilder que ens dibuixa el contingut de cada item
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
          itemCount: llistaEntrants.length,
          itemBuilder: (ctx, i) {
            // Rebem el context (ctx) i la posició i
            return EntrantCard(entrant: llistaEntrants[i]);
          },
          // La propietat gridDelegate ens serveix per configurar el Grid
          // per al GridView.builder. Concretament "deleguem" el disseny en
          // un SliverGridDelegateWithFixedCrossAxisCount, que ens ofereix
          // la possibilitat de configurar-lo amb un nombre fix de columnes
          // i controlar com es distribueixen els elements dins seu.
          // Fem ús de les propietats obtingudes al principi de la funció
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // Nombre de columnes en el grid
            crossAxisCount: crossAxisCount,
            // Proporció alçada/amplada (4:3)
            childAspectRatio: 0.75,
            // Espai entre les columnes (eix horitzontal) en píxels.
            crossAxisSpacing: spacing,
            // Espai entre les files (eix vertical) en píxels.
            mainAxisSpacing: spacing,
          ),
        );
      },
    );
  }
}

// Classe per descriure les diferents targetes dels productes
class EntrantCard extends StatelessWidget {
  final Entrant entrant;

  const EntrantCard({super.key, required this.entrant});

  @override
  Widget build(BuildContext context) {
    // Agafem la URL que farà de prefix de les imatges
    // des del ServiceLocator.
    final String baseUrl = ServiceLocator().getRemoteUrl();

    return Card(
      // Controla com es retallen les vores arrodonides de la targeta
      clipBehavior: Clip.antiAlias,
      // Elevació per a l'ombra
      elevation: 2,
      // Forma arrodonida per a les vores (12 px de radi)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        // Equival al GestureDetector, però amb una interacció més visual
        onTap: () {
          // Navegar a detalls de l'entrant
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return EntrantDetall(entrant: entrant);
              },
            ),
          );
        },
        child: Column(
          // La targeta contindrà en forma de columna la imatge i la
          // informació del plat.
          // Fem ús de dos Expanded per a que ocupen tota l'espai
          // disponible, al 60 i 40% d'alçada cadascun.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imatge (60% de l'altura)
            Expanded(flex: 6, child: _buildImage(baseUrl)),

            // Informació (40% de l'altura)
            Expanded(flex: 4, child: _buildInfo(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String baseUrl) {
    return Image.network(
      // Agafem la imatge de l'entrant
      entrant.img ?? '',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Si no es troba la imatge s'informa que
        // la imatge no és disponible. Fem ús d'un Container que conté
        // un Column amb una icona i el text.
        return Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 8),
              Text(
                'Imatge no disponible',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        );
      },
      // propietat loadingBuilder del Image: Defineix el widget que es
      // retornarà mentre s'està carregant la imatge. Farem ús d'un
      // Indicador de progrés circular.
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[100],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }

  // Mètode per retornar la part de baix de la targeta
  // Afegim un SingleChildScrollView perquè no se'ns desborde el contingut
  Widget _buildInfo(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Preu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Espai flexible per espentar el preu a la dreta
                const Spacer(),
                // Text amb el preu
                Text(
                  "${entrant.price?.toStringAsFixed(2)}€",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            // Nom de l'entrant. Si se'n passa de dues línies,
            //s'amaga el text que sobra
            Text(
              entrant.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2, // Permet dues línies per al nom
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.2, // Espaiat entre línies
              ),
            ),

            // Informació addicional: Afegim un text dins un padding
            if (entrant.additionalInfo != null &&
                entrant.additionalInfo!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  entrant.additionalInfo!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
