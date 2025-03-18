import 'second_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/energy_cubit.dart';
import 'package:flutter/material.dart';

class KineticEnergyForm extends StatefulWidget {
  KineticEnergyForm({super.key});

  @override
  _KineticEnergyFormState createState() => _KineticEnergyFormState();
}

class _KineticEnergyFormState extends State<KineticEnergyForm>{
final _formKey = GlobalKey<FormState>();
final _fieldWeight = TextEditingController();
final _fieldSpeed = TextEditingController();

  Widget build(BuildContext context) {
    final energyCubit = context.read<EnergyCubit>();
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20), child:
                        const Text("Масса объекта, кг",
             style: TextStyle(fontSize: 20, color: Colors.purple),
             ), ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return "Введите значение массы";
                try {
                  double mass = double.parse(value);
                  if (mass <= 0) return "Масса должна быть больше 0";
                } catch (e) {
                  return "Введите корректное число для массы";
                }
                return null; // Возвращаем null, если ошибок нет
              },
              controller: _fieldWeight,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final mass = double.tryParse(value) ?? 0;
                energyCubit.updateMass(mass);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                "Скорость объекта, м/с",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return "Введите значение скорости";
                try {
                  double.parse(value);
                } catch (e) {
                  return "Введите корректное число для скорости";
                }
                return null; // Возвращаем null, если ошибок нет
              },
              controller: _fieldSpeed,
              keyboardType: TextInputType.number,
                            onChanged: (value) {
                final speed = double.tryParse(value) ?? 0;
                energyCubit.updateSpeed(speed);
              },
            ),
            BlocBuilder<EnergyCubit, EnergyState>(
            builder: (context, state) {
            return CheckboxListTile(value: state.isAgreed, 
              title: Text("Я готов слить свои данные за 0 рублей в общий доступ"),
              onChanged: (value) {
                energyCubit.toggleAgreement(value ?? false);
              }
              );
            }
            ),
            const SizedBox(height: 20),
            BlocBuilder<EnergyCubit, EnergyState>(
            builder: (context, state) {
              return ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate() & state.isAgreed)
              {

                Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(mass: state.mass, speed: state.speed)));
              }
            }, child: const Text("Вычислить"));
            },
            ),
          ],
        ),
      ),
    );
    
  }
}

