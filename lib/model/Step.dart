class Steps {
  final String deskripsi;
  final int urutan;

  const Steps({
    required this.deskripsi,
    required this.urutan
  });

  factory Steps.fromJson(Map<String, dynamic> json){
    return Steps(
      deskripsi: json['deskripsi'],
      urutan: json['urutan'],
    );
  }
}