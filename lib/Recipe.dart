class Recipe {
  final int id;
  final String email;
  final String judul;
  final String backstory;
  final String asal;
  final int porsi;
  final int durasi;
  final String kategori;

  const Recipe({
    required this.id,
    required this.judul,
    required this.email,
    required this.backstory,
    required this.asal,
    required this.porsi,
    required this.durasi,
    required this.kategori,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['recipeID'],
      email: json['emailAuthor'],
      judul: json['judul'],
      backstory: json['backstory'],
      asal: json['asalDaerah'],
      porsi: json['servings'],
      durasi: json['durasi_menit'],
      kategori: json['kategori'],
    );
  }
}
