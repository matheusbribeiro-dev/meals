import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  Settings settings = Settings();
  List<Meal> _availableMeals = dummyMeals;

  void _filterMeals(Settings settings) 
  {
    setState(() {
      this.settings = settings;

      _availableMeals = dummyMeals.where((meal) {
        final filterGlutten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return 
          !filterGlutten
          && !filterLactose
          && !filterVegan
          && !filterVegetarian;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed'
          )
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1)
      ),
      routes: {
        AppRoutes.home : (ctx) => const TabsScreen(),
        AppRoutes.categoriesMeals : (ctx) => CategoriesMealsScreen(_availableMeals),
        AppRoutes.mealDetail : (ctx) => const MealDetailScreen(),
        AppRoutes.settings : (ctx) => SettingsScreen(settings, _filterMeals)
      }
    );
  }
}
