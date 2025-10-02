class Comarca {
  // TO-DO Hecho
  // Implementació de la classe Comarca
  String comarca;
  String? capital;
  String? poblacio;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;

  Comarca({
    required this.comarca,
    this.capital,
    this.poblacio,
    this.img,
    this.desc,
    this.latitud,
    this.longitud
  });

  @override
  String toString() => '''\x1B[34mNom:\t\t\x1B[36m$comarca\x1B[0m
\x1B[34mCapital:\t\x1B[36m$capital\x1B[0m
\x1B[34mPoblació:\t\x1B[36m$poblacio\x1B[0m
\x1B[34mImatge:\t\t\x1B[36m$img\x1B[0m
\x1B[34mDescripció:\t\x1B[36m$desc\x1B[0m
\x1B[34mLatitud:\t\x1B[32m$latitud\x1B[0m
\x1B[34mLongitud:\t\x1B[32m$longitud\x1B[0m''';
}
