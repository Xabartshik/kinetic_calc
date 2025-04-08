import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnergyCubit extends Cubit<EnergyState> {
  EnergyCubit() : super(EnergyState.initial());

  static const String _calculationsKey = 'saved_calculations';

  void updateMass(double mass) {
    emit(state.copyWith(mass: mass));
  }

  void updateSpeed(double speed) {
    emit(state.copyWith(speed: speed));
  }

  void toggleAgreement(bool isAgreed) {
    emit(state.copyWith(isAgreed: isAgreed));
  }

/*
Future — это объект в Dart, который представляет собой результат асинхронной операции, которая может завершиться успешно с результатом или завершиться с ошибкой. 
Это позволяет выполнять долгие операции (например, запросы к базе данных или сети) без блокировки основного потока выполнения.
*/


  // Сохраняем расчёт в SharedPreferences
  Future<void> saveCalculation(double mass, double speed) async {
    final prefs = await SharedPreferences.getInstance();
    final calculations = prefs.getStringList(_calculationsKey) ?? [];
    calculations.add(
      'Масса: $mass кг, Скорость: $speed м/с → Энергия: ${_calculateEnergy(mass, speed)} Дж',
    );
    await prefs.setStringList(_calculationsKey, calculations);
  }

  // Загружаем историю расчётов
  Future<List<String>> loadCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_calculationsKey) ?? [];
  }

  // Формула кинетической энергии
  double _calculateEnergy(double mass, double speed) {
    return mass * speed * speed / 2;
  }
}

class EnergyState {
  final double mass;
  final double speed;
  final bool isAgreed;

  EnergyState({
    required this.mass,
    required this.speed,
    required this.isAgreed,
  });

  factory EnergyState.initial() {
    return EnergyState(
      mass: 0,
      speed: 0,
      isAgreed: false,
    );
  }

  EnergyState copyWith({
    double? mass,
    double? speed,
    bool? isAgreed,
  }) {
    return EnergyState(
      mass: mass ?? this.mass,
      speed: speed ?? this.speed,
      isAgreed: isAgreed ?? this.isAgreed,
    );
  }
}