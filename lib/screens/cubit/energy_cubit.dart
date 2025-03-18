import 'package:flutter_bloc/flutter_bloc.dart';

class EnergyCubit extends Cubit<EnergyState> {
  EnergyCubit() : super(EnergyState.initial());

  void updateMass(double mass) {
    emit(state.copyWith(mass: mass));
  }

  void updateSpeed(double speed) {
    emit(state.copyWith(speed: speed));
  }

  void toggleAgreement(bool isAgreed) {
    emit(state.copyWith(isAgreed: isAgreed));
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