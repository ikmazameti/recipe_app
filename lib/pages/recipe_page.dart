import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text(
          "Recipe Book",
        ),
      ),
      body: SafeArea(
        child: _buildUI(context),
      ),
    );
  }

  Widget _buildUI(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            _recipeImage(context),
            _recipeDetails(context),
            _recipeIngredients(context),
            _recipesIntructions(context),
          ],
        ),
      );

  Widget _recipeImage(BuildContext context) => Container(
        height: MediaQuery.sizeOf(context).height * 0.40,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              recipe.image,
            ),
          ),
        ),
      );

  Widget _recipeDetails(BuildContext context) => Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${recipe.cuisine}, ${recipe.difficulty}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "${recipe.cuisine}, ${recipe.difficulty}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Prep time: ${recipe.prepTimeMinutes} Minutes | Cook time: ${recipe.cookTimeMinutes} minutes",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "${recipe.rating.toString()} * |   ${recipe.reviewCount} reviews",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget _recipeIngredients(BuildContext context) => Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          children: recipe.ingredients
              .map((i) => Row(
                    children: [
                      const Icon(
                        Icons.check_box,
                      ),
                      Text(" $i")
                    ],
                  ))
              .toList(),
        ),
      );

  Widget _recipesIntructions(BuildContext context) => Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recipe.instructions
              .map((i) => Row(
                    children: [
                      Text(
                        "${recipe.instructions.indexOf(i)}. $i\n",
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ))
              .toList(),
        ),
      );
}
