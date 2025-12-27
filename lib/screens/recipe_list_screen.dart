import 'package:flutter/material.dart';
import '../ data/recipe_data.dart';
import '../models/recipe.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Recipe> recipes = parseRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.restaurant),
            title: Text(recipes[index].title),
          );
        },
      ),
    );
  }
}
