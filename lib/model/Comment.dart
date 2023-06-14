class Comment {
  final String email;
  final int rating;
  final int recipeID;
  final String deskripsi;

  const Comment({
    required this.email,
    required this.rating,
    required this.recipeID,
    required this.deskripsi,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      email: json['email'],
      rating: json['rating'],
      recipeID: json['recipeID'],
      deskripsi: json['deskripsi'],
    );
  }
}