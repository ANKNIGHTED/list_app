import 'package:flutter/material.dart';
import 'package:list_app/cubit/food_cubit.dart';
import 'package:list_app/data/repositories/food_repository.dart';
import 'package:list_app/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodCubit>(
      create: (context) => FoodCubit(FoodRepository()),
      child: MaterialApp(
        home: BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            return Home();
          },
        ),

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
