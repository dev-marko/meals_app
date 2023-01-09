import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/data/dummy_data.dart';
import 'package:flutter_complete_guide/models/meal.dart';

import 'package:flutter_complete_guide/screens/categories_screen.dart';
import 'package:flutter_complete_guide/screens/category_meals_screen.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_detail_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((entity) {
        if (_filters['gluten'] && !entity.isGlutenFree) return false;
        if (_filters['lactose'] && !entity.isLactoseFree) return false;
        if (_filters['vegan'] && !entity.isVegan) return false;
        if (_filters['vegetarian'] && !entity.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontFamily: 'Raleway',
              ),
              bodySmall: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontFamily: 'Raleway',
              ),
              titleLarge: TextStyle(
                fontSize: 24,
                fontFamily: 'Raleway',
              ),
              titleMedium: TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
              titleSmall: TextStyle(
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      home: TabsScreen(),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
