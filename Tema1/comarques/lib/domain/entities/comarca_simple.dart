class ComarcaSimple {
  String comarca;
  String? img;

  // Constructor
  ComarcaSimple({required this.comarca, this.img});

  @override
  String toString() => '''\x1B[34mNom:\t\x1B[36m$comarca\x1B[0m
\x1B[34mImatge:\t\x1B[36m$img\n\x1B[0m''';
}
