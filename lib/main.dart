import 'package:flutter/material.dart';

import 'screens/first_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/cubit/energy_cubit.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => EnergyCubit(), // Создаем Cubit
        child: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Кинетическая энергия"),
        shadowColor: Colors.purple,
      ),
      body: KineticEnergyForm(),
    );
  }
}

