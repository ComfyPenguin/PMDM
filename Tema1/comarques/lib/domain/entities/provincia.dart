class Provincia {
  String nom; // Declarem el nom
  String? imatge; // La url a la imatge pot ser null

  /* 
  Constructor amb arguments amb nom: 
   - nom és obligatori, i 
   - imatge opcional.
  */

  Provincia({
    required this.nom,
    this.imatge,
  });

  @override
  String toString() => '''\x1B[34mNom:\t\x1B[36m$nom\x1B[0m
\x1B[34mImatge:\t\x1B[36m$imatge\n\x1B[0m''';
}
