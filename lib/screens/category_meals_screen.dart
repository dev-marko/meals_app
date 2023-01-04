import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

import '../data/dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen({this.categoryId, this.categoryTitle});

  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final filteredMeals = DUMMY_MEALS
        .where((entity) => entity.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            title: filteredMeals[index].title,
            imageUrl: filteredMeals[index].imageUrl,
            duration: filteredMeals[index].duration,
            complexity: filteredMeals[index].complexity,
            affordability: filteredMeals[index].affordability,
          );
        },
        itemCount: filteredMeals.length,
      ),
    );
  }
}
