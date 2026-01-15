import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_app/cubit/food_cubit.dart';
import 'package:list_app/cubit/recipe_cubit.dart';
import 'package:list_app/pages/food_details_page.dart';
import 'package:list_app/util/foodtile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        leading: IconButton(
          onPressed: () {
            context.read<FoodCubit>().clearSearch();
          },
          icon: Icon(Icons.refresh),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            if (state is FoodInitial) {
              return FoodInputField();
            } else if (state is FoodLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FoodLoaded) {
              return ListView.builder(
                itemCount: state.food.length,
                itemBuilder: (context, index) {
                  final food = state.food[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<RecipeCubit>().fetchDetails(food.id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodDetailsPage(),
                        ),
                      );
                    },
                    child: FoodTile(food: food),
                  );
                },
              );
            } else if (state is FoodError) {
              return Center(child: Text(state.message));
            } else {
              return FoodInputField();
            }
          },
        ),
      ),
    );
  }
}

class FoodInputField extends StatelessWidget {
  const FoodInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onSubmitted: (value) {
          context.read<FoodCubit>().getFood(value);
        },
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
