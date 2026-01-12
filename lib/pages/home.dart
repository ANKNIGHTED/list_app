import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:list_app/cubit/food_cubit.dart';
import 'package:list_app/data/model/food.dart';
import 'package:list_app/data/repositories/food_repository.dart';
import 'package:list_app/util/foodtile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<FoodCubit>();
      cubit.getFood("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            if (state is FoodInitial) {
              return buildInitialInput();
            } else if (state is FoodLoading) {
              return buildLoading();
            } else if (state is FoodLoaded) {
              final foods = state.food;
              return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return FoodTile(food: food);
                },
              );
            } else if (state is FoodError) {
              return Center(child: Text(state.message));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodInputField(),
                  //search bar
                  SizedBox(height: 16.0),
                  Text(
                    'Popular Food',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),

                  //menu list
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return FoodTile(
                          food: FoodRepository().fetchFood() as Food,
                        );
                      },
                    ),
                  ),
                ],
              );
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
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onSubmitted: (value) => submitFood(context, value),
      textInputAction: TextInputAction.search,
    );
  }
}

Widget buildInitialInput() {
  return Center(child: FoodInputField());
}

Widget buildLoading() {
  return Center(child: CircularProgressIndicator());
}

Column buildColumnWithData(Food food) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        food.title,
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
      ),
      Text("ID ${food.id}", style: TextStyle(fontSize: 30)),
    ],
  );
}

void submitFood(BuildContext context, String name) {
  final foodCubit = context.read<FoodCubit>();
  foodCubit.getFood(name);
}
