import 'package:flutter/material.dart';

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
double KineticEnergy(double mass, double speed)
{
  return mass*speed*speed/2;
}
class _KineticEnergyFormState extends State<KineticEnergyForm>{
final _formKey = GlobalKey<FormState>();
final _fieldWeight = TextEditingController();
final _fieldSpeed = TextEditingController();
double energy = 0;
bool _agreementDataProcessing = false;
bool _agreementAd = true;
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

            TextFormField(validator: (value) {
              if (value!.isEmpty) return "Введите значение массы";
              if (double.parse(_fieldWeight.text)<=0) return "Масса должна быть не меньше 0";
            }, controller: _fieldWeight, keyboardType: TextInputType.numberWithOptions()),
            Padding(padding: EdgeInsets.only(top: 20), child:
                        const Text("Скорость объекта, м/с",
             style: TextStyle(fontSize: 20, color: Colors.purple),
             ), ),

            TextFormField(validator: (value) {
              if (value!.isEmpty) return "Введите значение скорости";
              if (double.parse(_fieldSpeed.text)<=0) return "Скорость должна быть не меньше 0";
            }, controller: _fieldSpeed, keyboardType: TextInputType.numberWithOptions(),),
            CheckboxListTile(value: _agreementDataProcessing, 
            title: Text("Я готов слить свои данные за 0 рублей в общий доступ"),
            onChanged: (bool? value) => setState(() => _agreementDataProcessing = value!)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate() & _agreementDataProcessing)
              {
                energy = KineticEnergy(double.parse(_fieldWeight.text), double.parse(_fieldSpeed.text));
                Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(energy: energy)));
              }
            }, child: const Text("Вычислить"))
          ],
        ),
      ),
    );
    
  }
}

class SecondScreen extends StatelessWidget {
  double energy;
  SecondScreen({required this.energy});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Кинетическая энергия " + energy.toString() + " Дж"),
        ),
        body: Center(
          child: ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("Закрыть экран"))
        ),
      ),
    );
  }
}