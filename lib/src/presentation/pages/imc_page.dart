import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/imc_cubit.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora de IMC")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Peso (kg)"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Altura (m)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final weight = double.tryParse(_weightController.text);
                final height = double.tryParse(_heightController.text);

                if (weight != null && height != null) {
                  context.read<ImcCubit>().calculateImc(
                    weight: weight,
                    height: height,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Insira valores válidos")),
                  );
                }
              },
              child: const Text("Calcular IMC"),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: BlocBuilder<ImcCubit, ImcState>(
                  builder: (context, state) {
                    if (state is ImcInitial) {
                      return const Text(
                        "Digite seu peso e altura para calcular",
                        style: TextStyle(fontSize: 18),
                      );
                    } else if (state is ImcCalculated) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "IMC: ${state.imc.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.classification,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    } else if (state is ImcError) {
                      return Text(
                        "Erro: ${state.message}",
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
