// Entitat Pizza

class Pizza {
  String id = "";
  String nom = "";
  String? desc;
  bool? vegetariana;
  String? img;
  double? preu;
  List<String>? alergens;

  Pizza({
    required this.id,
    required this.nom,
    this.desc,
    this.vegetariana,
    this.img,
    this.preu,
    this.alergens,
  });
}
