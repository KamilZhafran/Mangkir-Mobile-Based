import 'Step.dart';
import 'Tool.dart';
import 'Ingredient.dart';

class RecipeDetail{
  final String author;
  final String dataRecipe;
  final List<Ingredient> dataIngredients;
  final List<Tool> dataTools;
  final List<Steps> dataSteps;

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