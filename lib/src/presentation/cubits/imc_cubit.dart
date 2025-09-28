import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ImcState {}

class ImcInitial extends ImcState {}

class ImcCalculated extends ImcState {
  final double imc;
  final String classification;

  ImcCalculated(this.imc, this.classification);
}

class ImcError extends ImcState {
  final String message;

  ImcError({required this.message});
}

class ImcCubit extends Cubit<ImcState> {
  ImcCubit() : super(ImcInitial());

  void calculateImc({required double weight, required double height}) {
    try {
      if (weight <= 0 || height <= 0) {
        emit(ImcError(message: "Peso e altura devem ser maiores que zero"));
        return;
      }

      final imc = weight / (height * height);

      String classification;
      if (imc < 18.5) {
        classification = "Abaixo do peso";
      } else if (imc < 24.9) {
        classification = "Peso normal";
      } else if (imc < 29.9) {
        classification = "Sobrepeso";
      } else {
        classification = "Obesidade";
      }

      emit(ImcCalculated(imc, classification));
    } catch (e) {
      emit(ImcError(message: "Erro ao calcular o IMC"));
    }
  }
}
