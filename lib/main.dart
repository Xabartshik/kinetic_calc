import 'package:flutter/material.dart';
import 'second_screen.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Кинетическая энергия"),
          shadowColor: Colors.purple,
        ),
        body: KineticEnergyForm(),
      ),
    );
  }
}

class KineticEnergyForm extends StatefulWidget {
  KineticEnergyForm({super.key});

  @override
  _KineticEnergyFormState createState() => _KineticEnergyFormState();
}

class _KineticEnergyFormState extends State<KineticEnergyForm>{
final _formKey = GlobalKey<FormState>();
final _fieldWeight = TextEditingController();
final _fieldSpeed = TextEditingController();
double energy = 0;
bool _agreementDataProcessing = false;
  Widget build(BuildContext context) {
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
                  double speed = double.parse(value);
                  if (speed <= 0) return "Скорость должна быть больше 0";
                } catch (e) {
                  return "Введите корректное число для скорости";
                }
                return null; // Возвращаем null, если ошибок нет
              },
              controller: _fieldSpeed,
              keyboardType: TextInputType.number,
            ),
            CheckboxListTile(value: _agreementDataProcessing, 
            title: Text("Я готов слить свои данные за 0 рублей в общий доступ"),
            onChanged: (bool? value) => setState(() => _agreementDataProcessing = value!)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate() & _agreementDataProcessing)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(mass: double.parse(_fieldWeight.text), speed: double.parse(_fieldSpeed.text))));
              }
            }, child: const Text("Вычислить"))
          ],
        ),
      ),
    );
    
  }
}

