import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './src/presentation/pages/imc_page.dart';
import 'src/presentation/cubits/imc_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(create: (_) => ImcCubit(), child: const ImcPage()),
    );
  }
}
