import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/energy_cubit.dart';

double KineticEnergy(double mass, double speed)
{
  return mass*speed*speed/2;
}

class SecondScreen extends StatelessWidget {
  double mass, speed;
  SecondScreen({required this.mass, required this.speed});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Кинетическая энергия"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Padding(padding: EdgeInsets.only(top: 20), child:
                        Text("Скорость объекта: $speed м/с",
             style: TextStyle(fontSize: 20, color: Colors.purple),
             ), ),
            Padding(padding: EdgeInsets.only(top: 20), child:
                        Text("Масса объекта: $mass кг",
             style: TextStyle(fontSize: 20, color: Colors.purple),
             ), ),
            Padding(padding: EdgeInsets.only(top: 20), child:
                        Text("Кинетическая энергия объекта: ${KineticEnergy(mass, speed)} ДЖ",
             style: TextStyle(fontSize: 20, color: Colors.purple),
             ), ),
             Padding(padding: EdgeInsets.only(top: 20), child:
            ElevatedButton(onPressed: () {
              context.read<EnergyCubit>().saveCalculation(mass, speed);
              Navigator.pop(context);
              }, child: Text("Закрыть экран"))),

            ],
          ) 
        ),
      ),
    );
  }
}