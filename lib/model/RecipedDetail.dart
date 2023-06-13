class RecipeDetail{
  final String author;
  final String dataRecipe;
  final String dataIngredients;
  final String dataTools;
  final String dataSteps;

  const RecipeDetail({
    required this.author,
    required this.dataRecipe,
    required this.dataIngredients,
    required this.dataTools,
    required this.dataSteps,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      author: json['author'],
      dataRecipe: json['data_recipe'],
      dataIngredients: json['data_ingredients'],
      dataTools: json['data_tools'],
      dataSteps: json['data_steps'],
    );
  }
}