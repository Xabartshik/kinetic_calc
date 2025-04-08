import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/first_screen.dart';
import 'screens/cubit/energy_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnergyCubit(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text("Калькулятор энергии")),
          body: KineticEnergyForm(),
        ),
      ),
    );
  }
}