import 'package:bloc_vs_riverpod_example/presentation/state/network/network_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/screen/facts_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: BlocProvider(
        create: (context) => NetworkInfoCubit(Connectivity()),
        child: MaterialApp(
          title: 'Random Fact',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: const FactsPage(),
        ),
      ),
    );
  }
}
