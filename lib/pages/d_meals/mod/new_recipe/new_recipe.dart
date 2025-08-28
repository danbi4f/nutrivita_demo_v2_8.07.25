import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/meal.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final TextEditingController _nameController = TextEditingController();
  final List<SurveyFoods> _foods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Recipe')),
      body: CustomContainer(
        isGradient: true,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Meal Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _foods.length,
                  itemBuilder: (context, index) {
                    final food = _foods[index];
                    return ListTile(
                      title: Text(food.descriptionPL),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _foods.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Demo: dodajemy przykładowy SurveyFoods
                  setState(() {
                    _foods.add(
                      SurveyFoods(
                        description: 'Example Food',
                        descriptionPL: 'Przykładowe Jedzenie',
                        foodClass: 'A',
                        fdcId: 0,
                        nutrients: {},
                        nameNutrient: {},
                        unitNameNutrient: {},
                      ),
                    );
                  });
                },
                child: const Text('Add Example Food'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty || _foods.isEmpty) return;

                  final newMeal = Meal(
                    name: _nameController.text,
                    foods: _foods,
                  );

                  // Dodajemy posiłek przez bloc
                  context.read<MealsBloc>().add(AddMeal(newMeal));

                  Navigator.pop(context); // wracamy do listy posiłków
                },
                child: const Text('Save Meal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
