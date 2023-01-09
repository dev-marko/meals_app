import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> filteredMeals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    filteredMeals = widget.availableMeals
        .where((entity) => entity.categories.contains(categoryId))
        .toList();
  }

  void _removeMeal(String mealId) {
    setState(() {
      filteredMeals.removeWhere((entity) => entity.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: filteredMeals[index].id,
            title: filteredMeals[index].title,
            imageUrl: filteredMeals[index].imageUrl,
            duration: filteredMeals[index].duration,
            complexity: filteredMeals[index].complexity,
            affordability: filteredMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: filteredMeals.length,
      ),
    );
  }
}
